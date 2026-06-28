extends AIMove

const ANIMATION_LENGTH : float = 1.0


func check_transition(delta: float) -> String:
	if !player:
		"idle"
	
	if raycast.is_colliding():
		return "okay"

	var distance := distance_to_player()	
	if distance <= params.melee_trigger:
		return "melee"
	if distance <= params.follow_trigger:
		return "standing"
	return "okay"


func update(delta: float) -> void:
	follow_target(params.speed, delta)
	rotate_character(player.global_position, params.rotate_speed, delta)
 

func on_enter() -> void:
	pass


func on_exit() -> void:
	nav_agent.velocity = Vector3.ZERO
