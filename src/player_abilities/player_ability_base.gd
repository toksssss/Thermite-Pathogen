extends Resource
class_name PlayerAbilityStrategy

@export var behavior : BaseAbilityBehavior
@export var cooldown : float
var is_cooldown : bool

@warning_ignore("unused_parameter")
func apply_strategy(player: Player) -> void:
	if is_cooldown:
		return
	behavior.apply_behavior(player)
