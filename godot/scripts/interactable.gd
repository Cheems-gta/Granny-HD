extends Node3D

@export var open_angle: float = -95.0
@export var hinge_axis: Vector3 = Vector3.UP
var hinge: Node3D
var opened: bool = false

func activate() -> void:
    if not is_instance_valid(hinge):
        return
    opened = not opened
    var axis: Vector3 = hinge_axis.normalized()
    var angle: float = deg_to_rad(open_angle if opened else 0.0)
    var tween: Tween = create_tween()
    tween.tween_property(hinge, "rotation", axis * angle, 0.42)
