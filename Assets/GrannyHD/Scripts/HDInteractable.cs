using UnityEngine;

// Original independent prototype logic, not Granny source code.
public class HDInteractable : MonoBehaviour
{
    public Transform hingedObject;
    public Vector3 openedEuler = new Vector3(0, -95, 0);
    Quaternion closedRotation;
    bool opened;
    void Start() { if (hingedObject) closedRotation = hingedObject.localRotation; }
    public void Activate()
    {
        opened = !opened;
        if (hingedObject) hingedObject.localRotation = closedRotation * Quaternion.Euler(opened ? openedEuler : Vector3.zero);
    }
}
