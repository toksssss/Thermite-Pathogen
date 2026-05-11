extends Move

var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")

const CROUCH_THRESHOLD : float = 7.5

func check_relevance(input: InputPackage) -> String:
	if !player.is_on_floor():
		return "falling"
	
	if player.velocity.length() <= CROUCH_THRESHOLD:
			return "crouch"
	
	if head_raycast.is_colliding():
		if player.velocity.length() >= CROUCH_THRESHOLD:
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
	
	var speed : float = vel_comp.velocity.length()
	speed = lerp(speed, 0.0, delta * 4)
	var target : Vector3 = direction * speed
	vel_comp.accelerate_to(target, direction, delta)


func on_enter_state() -> void:
	boost()
	player.is_crouching = true
	set_crouch_collision_shape()


func on_exit_state() -> void:
	player.is_crouching = false
	set_stand_collision_shape()


func boost() -> void:
	var slide_vel : Vector3 = (
		vel_comp.velocity.normalized() * 
		base_speed * 
		slide_boost_speed_multiplier
	)
	vel_comp.velocity = slide_vel
