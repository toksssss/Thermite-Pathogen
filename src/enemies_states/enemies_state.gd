@abstract
extends Node
class_name EnemiesState

#var disabled: bool

var npc : CharacterBody3D
var player : Player
var navigation_agent : NavigationAgent3D


@warning_ignore("unused_signal")
signal transitioned(state: EnemiesState, new_state_name: String)

func enter() -> void:
	pass

func exit() -> void:
	pass

@warning_ignore("unused_parameter")
func update(delta: float) -> void:
	pass

@warning_ignore("unused_parameter")
func physics_update(delta: float) -> void:
	pass
