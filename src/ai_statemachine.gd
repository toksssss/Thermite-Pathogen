extends Node
class_name AIStateMachine

@export var animation_player : AnimationPlayer
@export var character : CharacterBody3D
@export var navigation_agent : NavigationAgent3D
@export var weapon : WeaponStrategy

var moves : Dictionary[String, AIMove] # { String : AIMove }
var current_move : AIMove


func _ready() -> void:
	navigation_agent.velocity_computed.connect(_on_velocity_computed)
	accept_states()
	current_move = moves["idle"]
	switch_to("idle")


func _physics_process(delta: float) -> void:
	var verdict : String = current_move.check_transition(delta)
	if verdict != "okay":
		switch_to(verdict)
	current_move.update(delta)
	
	character.move_and_slide()


func switch_to(next_state_name : String) -> void:
	print(current_move.move_name + " -> " + next_state_name)
	current_move.on_exit()
	current_move = moves[next_state_name]
	current_move.mark_enter_state()
	current_move.on_enter()
	animation_player.play(current_move.animation)


func accept_states() -> void:
	for child in get_children():
		if child is AIMove:
			var move : AIMove = child as AIMove
			moves[move.move_name] = child
			move.animator = animation_player
			move.character = character
			move.player = get_tree().get_first_node_in_group("player")
			move.nav_agent = navigation_agent
			move.weapon = weapon

func _on_velocity_computed(safe_vel: Vector3) -> void:
	character.velocity = safe_vel
