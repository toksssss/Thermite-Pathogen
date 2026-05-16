extends Area3D
class_name Hitbox

@export var parent : Node3D

@export var health : HealthComponent
@export var fsm : AIStateMachine


@export_category("Crit")
@export var is_crit_hitbox : bool = false
@export var crit_damage_multiplier : float = 1.5

func damage(attack: AttackData) -> void:
	if health:
		if is_crit_hitbox:
			attack.damage *= crit_damage_multiplier
		if attack.is_stunned:
			if fsm:
				fsm.switch_to("stunned")

		health.damage(attack)
