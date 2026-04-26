extends Node
class_name EnemiesStateMachine

var current_state : EnemiesState
var states: Dictionary[String, EnemiesState] = {}

func _ready() -> void:
	for child in get_children():
		if child is EnemiesState:
			states[child.name.to_lower()] = child

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
