extends Throwable
class_name Grenade

@export var particles : GPUParticles3D

func _on_timer_timeout() -> void:
	particles.restart()
