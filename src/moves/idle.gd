extends Move

func check_relevance(input: InputPackage) -> String:
	if !player.is_on_floor():
		return "falling"
	
	input.actions.sort_custom(moves_priority_sort)
	return input.actions[0]

func on_enter_state():
	player.velocity = Vector3.ZERO
