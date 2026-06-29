extends Node
class_name StageMachine

@export var initial_state : LevelStage

static var instance : StageMachine:
	get:
		if GameplayManager.instance == null:
			return null
		return GameplayManager.instance.stage_machine

var s_timer : Timer

var current_state : LevelStage
var states: Dictionary[String, LevelStage] = {}

func _ready() -> void:
	s_timer = $STimer
	
	for child in get_children():
		if child is LevelStage:
			var state: LevelStage = child
			states[child.name.to_lower()] = child
			state.transitioned.connect(_on_child_transition)
			state.timer = s_timer
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _on_child_transition(state: LevelStage, new_state_name: String) -> void:
	if state != current_state:
		return
	
	var new_state : LevelStage = states[new_state_name.to_lower()]
	if !new_state:
		print_debug("Failed. Invalid new stage name")
		return
	
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state

func force_new_state(new_state_name : String) -> void:
	var new_state : LevelStage = states[new_state_name.to_lower()]
	if !new_state:
		print_debug("Failed. Invalid new stage name")
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
