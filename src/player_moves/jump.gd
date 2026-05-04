extends Move

@export var jump_velocity : float = 4.5

var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")

func check_relevance(input: InputPackage) -> String:
	if player.is_on_floor():
		input.actions.sort_custom(moves_priority_sort)
		return input.actions[0]
	return "okay"

func update(input: InputPackage, delta: float) -> void:
	player.velocity = velocity_by_input(input, delta)
	player.move_and_slide()

func on_enter_state() -> void:
	player.velocity.y += jump_velocity

func velocity_by_input(input: InputPackage, delta: float) -> Vector3:
	var direction : Vector3 = (player.global_transform.basis * 
	Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	var temp_vel : Vector3 = player.velocity
	
	var temp_accel : float
	var target : Vector3 = direction * base_speed
	
	if direction.dot(temp_vel) > 0:
		temp_accel = acceleration
	else:
		temp_accel = deccelartion
	
	#temp_vel = lerp(temp_vel, target, temp_accel * delta)
	temp_vel.x = lerp(temp_vel.x, target.x, delta * temp_accel)
	temp_vel.z = lerp(temp_vel.z, target.z, delta * temp_accel)
	temp_vel.y -= gravity * delta
	return temp_vel
