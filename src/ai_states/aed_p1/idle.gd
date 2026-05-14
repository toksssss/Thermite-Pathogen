extends AIMove

@export var trigger_distance : int = 30

func check_transition(delta: float) -> String:
	var distance : float = character.global_position.distance_to(player.global_position)
	if distance <= trigger_distance:
		return "follow"
	return "okay"


func update(delta: float) -> void:
	pass
 

func on_enter() -> void:
	nav_agent.velocity = Vector3.ZERO


func on_exit() -> void:
	pass
