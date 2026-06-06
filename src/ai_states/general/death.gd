extends AIMove

const ANIMATION_LENGTH : float = 0.75

func _ready() -> void:
	move_name = "death"

func check_transition(delta: float) -> String:
	if works_longer_than(ANIMATION_LENGTH):
		return "death"
	return "okay"


func update(delta: float) -> void:
	pass
 

func on_enter() -> void:
	collider.disabled = true


func on_exit() -> void:
	character.queue_free.call_deferred()
