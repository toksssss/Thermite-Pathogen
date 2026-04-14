extends Area3D
class_name Hitbox

@export var health : HealthComponent

func damage(attack: AttackData) -> void:
	if health:
		health.damage(attack)
