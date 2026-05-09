extends Node
class_name HealthComponent

@export var health : float = 100.0

func damage(attack: AttackData) -> void:
	health -= attack.damage
	
	if health <= 0:
		if attack.source:
			attack.source.kill_count += 1
		get_parent().queue_free()
