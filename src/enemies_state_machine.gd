extends Node
class_name EnemiesStateMachine

@export var initial_state : EnemiesState

@export var npc : CharacterBody3D
@export var navigation_agent : NavigationAgent3D

var current_state : EnemiesState
var states: Dictionary[String, EnemiesState] = {}

func _ready() -> void:
	@warning_ignore("unsafe_property_access", "unsafe_call_argument")
	navigation_agent.velocity_computed.connect(npc._on_velocity_computed)
	
	for child in get_children():
		if child is EnemiesState:
			var state: EnemiesState = child

			states[child.name.to_lower()] = child
			state.transitioned.connect(_on_child_transition)
			state.player = get_tree().get_first_node_in_group("player")
			state.npc = npc
			state.navigation_agent = navigation_agent
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _on_child_transition(state: EnemiesState, new_state_name: String) -> void:
	if state != current_state:
		return
	
	var new_state : EnemiesState = states[new_state_name.to_lower()]
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
	
	
