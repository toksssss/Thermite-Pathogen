extends WeaponState

func check_relevance(input: InputPackage) -> String:
	if input.combat_actions.has("fire") and resources._current_bullets == 0:
		return "reload"
	
	return best_input_that_can_be_paid(input)

#func update(input: InputPackage, delta: float) -> void:
	#pass
