extends WeaponState

func check_relevance(input: InputPackage) -> String:
	# Хардкод, но бля, мне похуй
	
	if input.combat_actions.has("fire") and resources._current_bullets == 0:
		return "reload"
	
	if input.combat_actions.has("reload") and resources._current_bullets == resources.max_bullets:
		return "okay"
	
	return best_input_that_can_be_paid(input)

#func update(input: InputPackage, delta: float) -> void:
	#pass
