extends AIMove

const ANIMATION_LENGTH : float = 2.0


func check_transition(delta: float) -> String:
	if works_longer_than(ANIMATION_LENGTH):
		return "idle"
	return "okay"


func update(delta: float) -> void:
	pass
 

func on_enter() -> void:
	collider.disabled = true


func on_exit() -> void:
	character.queue_free.call_deferred()
