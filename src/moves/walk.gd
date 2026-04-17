extends Move

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func check_relevance(input: InputPackage) -> String:
	if !player.is_on_floor():
		return "falling"
	
	if input.actions.has("crouch"):
		if player.velocity.length() > 12.0:
			return "slide"
	
	input.actions.sort_custom(moves_priority_sort)
	if input.actions[0] == "walk":
		return "okay"
	return input.actions[0]

func update(input: InputPackage, delta: float) -> void:
	player.velocity = velocity_by_input(input, delta)
	player.move_and_slide()

func velocity_by_input(input: InputPackage, delta: float) -> Vector3:
	var new_velocity = player.velocity
	
	var direction : Vector3 = (player.global_transform.basis *
	Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()

	new_velocity.x = direction.x * walk_speed
	new_velocity.z = direction.z * walk_speed
	
	if !player.is_on_floor():
		new_velocity.y -= gravity * delta
	
	return new_velocity
