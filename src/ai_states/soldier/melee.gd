extends AIMove

const ANIMATION_LENGTH : float = 0.75


func check_transition(delta: float) -> String:
	if works_longer_than(ANIMATION_LENGTH):
		var distance := distance_to_player()
		if distance >= character.melee_trigger:
			return "standing"
		elif distance >= character.follow_trigger:
			return "follow"
		else:
			return "melee"
	return "okay"


func update(delta: float) -> void:
	pass
 

func on_enter() -> void:
	pass


func on_exit() -> void:
	pass
