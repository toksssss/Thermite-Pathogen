@abstract
extends Node
class_name LevelStage

@export var enemie_scenes: Array[PackedScene]
@export var spawning_rate : float = 5.0
@export var threshold_min : int = 1.0

var timer : Timer
var is_cooldown: bool

@warning_ignore("unused_signal")
signal transitioned(state: EnemiesState, new_state_name: String)

func enter() -> void:
	timer.timeout.connect(func() -> void: is_cooldown = false)

func exit() -> void:
	pass

@warning_ignore("unused_parameter")
func update(delta: float) -> void:
	pass

@warning_ignore("unused_parameter")
func physics_update(delta: float) -> void:
	pass
