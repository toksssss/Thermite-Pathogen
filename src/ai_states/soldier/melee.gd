extends AIMove

const ANIMATION_LENGTH : float = 0.75


# trigger 1 = melee
# trigger 2 = follow

func check_transition(delta: float) -> String:
	if works_longer_than(ANIMATION_LENGTH):
		var distance := distance_to_player()
		if distance <= params.follow_trigger:
			return "standing"
		elif distance >= params.melee_trigger:
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
