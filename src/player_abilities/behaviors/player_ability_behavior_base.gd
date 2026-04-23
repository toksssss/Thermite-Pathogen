@abstract
extends Resource
class_name BaseAbilityBehavior

enum AbilityType {PASSIVE, ACTIVE}

@export var type : AbilityType

@warning_ignore("unused_parameter")
func apply_behavior(player: Player) -> void:
	pass
