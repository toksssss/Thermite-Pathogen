extends AIMove

func check_transition(delta: float) -> String:
	if !player:
		return "okay"
	
	var distance : float = character.global_position.distance_to(player.global_position)
	if distance <= character.follow_trigger:
		return "follow"
	return "okay"


func update(delta: float) -> void:
	pass
 

func on_enter() -> void:
	pass


func on_exit() -> void:
	pass
