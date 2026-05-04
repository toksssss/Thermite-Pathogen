extends WeaponState

func check_relevance(input: InputPackage) -> String:
	return best_input_that_can_be_paid(input)

#func update(input: InputPackage, delta: float) -> void:
	#pass
