using UnityEngine;

// First person mobile + desktop controller for a standalone test room.
[RequireComponent(typeof(CharacterController))]
public class HDExplorer : MonoBehaviour
{
    public Transform cameraPivot;
    public float walkSpeed = 2.5f;
    public float lookSensitivity = 0.14f;
    CharacterController body;
    float pitch, fallingSpeed;
    int movementFinger = -1, lookFinger = -1;
    Vector2 movementTouchStart;
    Vector2 touchMovement;
    void Awake()
    {
        body = GetComponent<CharacterController>();
        if (!cameraPivot && Camera.main) cameraPivot = Camera.main.transform;
        if (!Application.isMobilePlatform) { Cursor.lockState = CursorLockMode.Locked; Cursor.visible = false; }
    }
    void Update()
    {
        Vector2 look = Vector2.zero;
        touchMovement = Vector2.zero;
        for (int i = 0; i < Input.touchCount; ++i)
        {
            Touch t = Input.GetTouch(i);
            if (t.phase == TouchPhase.Began)
            {
                if (t.position.x < Screen.width * 0.45f && movementFinger < 0)
                { movementFinger = t.fingerId; movementTouchStart = t.position; }
                else if (lookFinger < 0) lookFinger = t.fingerId;
            }
            if (t.fingerId == movementFinger)
            {
                if (t.phase == TouchPhase.Ended || t.phase == TouchPhase.Canceled) movementFinger = -1;
                else touchMovement = Vector2.ClampMagnitude((t.position-movementTouchStart)/90f, 1f);
            }
            if (t.fingerId == lookFinger)
            {
                if (t.phase == TouchPhase.Ended || t.phase == TouchPhase.Canceled) lookFinger = -1;
                else look += t.deltaPosition;
            }
        }
        if (Input.touchCount == 0 && !Application.isMobilePlatform)
        {
            look = new Vector2(Input.GetAxis("Mouse X"), Input.GetAxis("Mouse Y")) * 16f;
        }
        transform.Rotate(0, look.x * lookSensitivity, 0);
        pitch = Mathf.Clamp(pitch - look.y * lookSensitivity, -80, 80);
        if (cameraPivot) cameraPivot.localRotation = Quaternion.Euler(pitch, 0, 0);
        Vector2 movement = Input.touchCount > 0 ? touchMovement : new Vector2(Input.GetAxisRaw("Horizontal"), Input.GetAxisRaw("Vertical"));
        movement = Vector2.ClampMagnitude(movement, 1f);
        if (body.isGrounded && fallingSpeed < 0f) fallingSpeed = -1f;
        fallingSpeed -= 14f * Time.deltaTime;
        Vector3 step = (transform.right * movement.x + transform.forward * movement.y) * walkSpeed + Vector3.up * fallingSpeed;
        body.Move(step * Time.deltaTime);
        if (Input.GetKeyDown(KeyCode.E)) TryInteract();
    }
    public void TryInteract()
    {
        if (!cameraPivot) return;
        RaycastHit hit;
        if (Physics.Raycast(cameraPivot.position, cameraPivot.forward, out hit, 3f))
        {
            HDInteractable prop = hit.collider.GetComponentInParent<HDInteractable>();
            if (prop) prop.Activate();
        }
    }
    void OnGUI()
    {
        GUI.color = Color.white;
        GUI.Label(new Rect(15, 12, 800, 36), "Granny HD - SOURCE-ONLY TEST ROOM (placeholder materials)");
        if (Application.isMobilePlatform)
        {
            GUI.Label(new Rect(20, Screen.height - 50, 260, 40), "LEFT move / RIGHT look");
            if (GUI.Button(new Rect(Screen.width - 115, Screen.height - 110, 100, 90), "USE")) TryInteract();
        }
        else GUI.Label(new Rect(15, 44, 650, 30), "WASD / Mouse / E interact");
    }
}
