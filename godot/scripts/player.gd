extends CharacterBody3D

const WALK_SPEED: float = 3.0
const LOOK_SENSITIVITY: float = 0.0032
const GRAVITY: float = 16.0

var camera: Camera3D
var move_touch: int = -1
var look_touch: int = -1
var move_start: Vector2 = Vector2.ZERO
var move_input: Vector2 = Vector2.ZERO
var pitch: float = 0.0

func _ready() -> void:
    camera = Camera3D.new()
    camera.name = "PlayerCamera"
    camera.position = Vector3(0.0, 1.50, 0.0)
    camera.fov = 72.0
    camera.current = true
    add_child(camera)
    if not OS.has_feature("mobile"):
        Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventScreenTouch:
        if event.pressed:
            var screen_width: float = get_viewport().get_visible_rect().size.x
            if event.position.x < screen_width * 0.48 and move_touch == -1:
                move_touch = event.index
                move_start = event.position
            elif look_touch == -1:
                look_touch = event.index
        else:
            if event.index == move_touch:
                move_touch = -1
                move_input = Vector2.ZERO
            if event.index == look_touch:
                look_touch = -1
    elif event is InputEventScreenDrag:
        if event.index == move_touch:
            move_input = ((event.position - move_start) / 94.0).limit_length(1.0)
        elif event.index == look_touch:
            _rotate_look(event.relative)
    elif event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
        _rotate_look(event.relative)
    elif event is InputEventKey and event.pressed and not event.echo:
        if event.keycode == KEY_E:
            try_interact()
        elif event.keycode == KEY_ESCAPE:
            Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
    elif event is InputEventMouseButton and event.pressed and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
        Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _rotate_look(delta: Vector2) -> void:
    rotation.y -= delta.x * LOOK_SENSITIVITY
    pitch = clamp(pitch - delta.y * LOOK_SENSITIVITY, deg_to_rad(-80.0), deg_to_rad(80.0))
    camera.rotation.x = pitch

func _physics_process(delta: float) -> void:
    var keys: Vector2 = Vector2.ZERO
    if Input.is_key_pressed(KEY_A): keys.x -= 1.0
    if Input.is_key_pressed(KEY_D): keys.x += 1.0
    if Input.is_key_pressed(KEY_W): keys.y -= 1.0
    if Input.is_key_pressed(KEY_S): keys.y += 1.0
    var pad: Vector2 = move_input if move_touch != -1 else keys
    pad = pad.limit_length(1.0)
    var direction: Vector3 = transform.basis.x * pad.x + transform.basis.z * pad.y
    velocity.x = direction.x * WALK_SPEED
    velocity.z = direction.z * WALK_SPEED
    if not is_on_floor():
        velocity.y -= GRAVITY * delta
    else:
        velocity.y = -0.1
    move_and_slide()

func try_interact() -> void:
    if camera == null:
        return
    var origin: Vector3 = camera.global_position
    var end: Vector3 = origin - camera.global_transform.basis.z * 3.3
    var query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(origin, end)
    query.exclude = [get_rid()]
    var hit: Dictionary = get_world_3d().direct_space_state.intersect_ray(query)
    if hit.is_empty():
        return
    var other: Object = hit["collider"]
    if other != null and other.has_meta("interact_target"):
        var target: Node = other.get_meta("interact_target")
        if is_instance_valid(target) and target.has_method("activate"):
            target.activate()
