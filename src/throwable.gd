@abstract
extends RigidBody3D
class_name Throwable

var force := Vector3(0, 0, 1)

func _enter_tree() -> void:
	apply_impulse(force)
