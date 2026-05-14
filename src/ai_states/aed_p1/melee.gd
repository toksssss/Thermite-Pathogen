extends AIMove

const ANIMATION_LENGTH : float = 1.5


func check_transition(delta: float) -> String:
	if works_longer_than(ANIMATION_LENGTH):
		return "follow"
	return "okay"


func update(delta: float) -> void:
	pass
 

func on_enter() -> void:
	nav_agent.velocity = Vector3.ZERO


func on_exit() -> void:
	pass
