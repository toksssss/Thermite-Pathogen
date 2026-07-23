extends Node
class_name HealthComponent

@export_category("Exports")
@export var health : float = 100.0
@export var fsm : StateMachine

@export_category("Toggles")
@export var is_god : bool = false

func damage(attack: AttackData) -> void:
	if is_god:
		return

	health -= attack.damage
	
	if health <= 0:
		if attack.source:
			#attack.source.kill_count += 1
			pass
		if fsm:
			fsm.switch_to("death")
		else:
			get_parent().queue_free.call_deferred()
