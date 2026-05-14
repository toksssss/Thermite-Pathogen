extends AIMove

@export var melee_trigger : float = 10.0
@export var idle_trigger : float = 30.0
@export var speed : float = 2.0

func check_transition(delta: float) -> String:
	var distance : float = character.global_position.distance_to(player.global_position)
	if distance <= melee_trigger:
		return "melee"
	if distance >= idle_trigger:
		return "idle"
	return "okay"


func update(delta: float) -> void:
	nav_agent.target_position = player.global_position
	
	if nav_agent.is_navigation_finished():
		character.velocity = Vector3.ZERO
		return
	
	var destination := nav_agent.get_next_path_position()
	var direction := (destination - character.global_position).normalized()
	nav_agent.velocity = direction * speed
	character.look_at(player.global_position)
 

func on_enter() -> void:
	pass


func on_exit() -> void:
	pass
