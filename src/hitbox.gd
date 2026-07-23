extends Area3D
class_name Hitbox

@export var parent : Node3D

@export var health : HealthComponent
@export var fsm : StateMachine

@export var visual_comp : VisualComponent
@export var camera_effects : HeadMovementComponent

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

	if visual_comp:
		visual_comp.damage(attack)
	
	if camera_effects:
		camera_effects.add_trauma_if_less_than(0.2, 0.3)
