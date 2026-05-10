extends Move

func check_relevance(input: InputPackage) -> String:
	if !player.is_on_floor():
		return "falling"
	
	input.actions.sort_custom(moves_priority_sort)
	return input.actions[0]

func update(input: InputPackage, delta: float) -> void:
	if player.velocity:
		vel_comp.accelerate_to_zero(delta)
