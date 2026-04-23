@abstract
extends Resource
class_name BasePlayerAbilityStrategy

@export var behavior : BaseAbilityBehavior

@warning_ignore("unused_parameter")
func apply_strategy(player: Player) -> void:
	behavior.apply_behavior(player)
