@abstract
extends RigidBody3D
class_name Throwable

var force := Vector3(0, 0, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer : Timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start(5)

func _enter_tree() -> void:
	apply_impulse(force)

func _on_timer_timeout() -> void:
	queue_free()
