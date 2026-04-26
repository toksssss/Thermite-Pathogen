extends Move

func check_relevance(input: InputPackage) -> String:
	if !player.is_on_floor():
		return "falling"
	
	input.actions.sort_custom(moves_priority_sort)
	return input.actions[0]

func update(input: InputPackage, delta: float) -> void:
	if player.velocity:
		player.velocity = accelerato_to_zero(input, delta)
	player.move_and_slide()

func accelerato_to_zero(_input: InputPackage, delta: float) -> Vector3:
	var new_velocity : Vector3 = player.velocity
	return lerp(new_velocity, Vector3(0, new_velocity.y, 0), delta * deccelartion)
