extends AIMove

@export var follow_trigger : int = 30

func check_transition(delta: float) -> String:
	var distance : float = character.global_position.distance_to(player.global_position)
	if distance <= follow_trigger:
		return "follow"
	return "okay"


func update(delta: float) -> void:
	pass
 

func on_enter() -> void:
	pass


func on_exit() -> void:
	pass
