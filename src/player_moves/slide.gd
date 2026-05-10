extends Move

var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")

func check_relevance(input: InputPackage) -> String:
	if !player.is_on_floor():
		return "falling"
	
	if player.velocity.length() <= 7.5:
			return "crouch"
	
	if head_raycast.is_colliding():
		if player.velocity.length() >= 7.5:
			return "okay"
		else:
			return "crouch"
	
	input.actions.sort_custom(moves_priority_sort)
	if input.actions[0] == "crouch":
		return "okay"
	return input.actions[0]

func update(input: InputPackage, delta: float) -> void:
	velocity_by_input(input, delta)

func velocity_by_input(input: InputPackage, delta: float) -> void:
	var direction : Vector3 = (player.global_transform.basis * 
	Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	
	var target : Vector3 = direction * vel_comp.velocity.length()
	vel_comp.accelerate_to(target, direction, delta)
	vel_comp.velocity = vel_comp.velocity.limit_length(vel_comp.velocity.length() - delta * 8)


func on_enter_state() -> void:
	boost()
	player.is_crouching = true
	set_crouch_collision_shape()

func on_exit_state() -> void:
	player.is_crouching = false
	set_stand_collision_shape()

func boost() -> void:
	vel_comp.velocity *= 1.5
