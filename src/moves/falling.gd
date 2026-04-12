extends Move

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func check_relevance(input: InputPackage) -> String:
	if player.is_on_floor():
		input.actions.sort_custom(moves_priority_sort)
		return input.actions[0]
	return "okay"


@warning_ignore("unused_parameter")
func update(input: InputPackage, delta: float) -> void:
	player.velocity = velocity_by_input(input, delta)
	player.move_and_slide()

func velocity_by_input(input, delta) -> Vector3:
	var new_velocity = player.velocity

	new_velocity.y -= gravity * delta
	
	return new_velocity
