extends Move

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func check_relevance(input: InputPackage) -> String:
	if !player.is_on_floor():
		return "falling"
	
	if player.velocity.length() <= 15:
			return "crouch"
	
	if head_raycast.is_colliding():
		if player.velocity.length() >= 15:
			return "okay"
		else:
			return "crouch"
	
	input.actions.sort_custom(moves_priority_sort)
	if input.actions[0] == "crouch":
		return "okay"
	return input.actions[0]

func update(input: InputPackage, delta: float) -> void:
	#set_head_position(delta)
	player.velocity = velocity_by_input(input, delta)
	player.move_and_slide()

func velocity_by_input(input: InputPackage, delta: float) -> Vector3:
	var direction : Vector3 = (player.global_transform.basis * 
	Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	var temp_vel : Vector3 = player.velocity
	temp_vel.y = 0
	
	var temp_accel : float
	var target : Vector3 = direction * base_speed * slide_speed_multiplier
	
	if direction.dot(temp_vel) > 0:
		temp_accel = acceleration
	else:
		temp_accel = deccelartion
	
	temp_vel = lerp(temp_vel, target, temp_accel / 2.0 * delta)
	return temp_vel

func on_enter_state() -> void:
	player.is_crouching = true
	set_crouch_collision_shape()

func on_exit_state() -> void:
	player.is_crouching = false
	set_stand_collision_shape()
