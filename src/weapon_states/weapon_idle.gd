extends WeaponState

func check_relevance(input: InputPackage) -> String:
	if input.combat_actions.is_empty():
		return "okay"
	input.combat_actions.sort_custom(moves_priority_sort)
	return input.combat_actions[0]

#func update(input: InputPackage, delta: float) -> void:
	#pass
