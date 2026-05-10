extends Move

@export var jump_velocity : float = 4.5

var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")

func check_relevance(input: InputPackage) -> String:
	if player.is_on_floor():
		input.actions.sort_custom(moves_priority_sort)
		return input.actions[0]
	return "okay"

func update(input: InputPackage, delta: float) -> void:
	velocity_by_input(input, delta)

func on_enter_state() -> void:
	vel_comp.jump(jump_velocity)

func velocity_by_input(input: InputPackage, delta: float) -> void:
	var direction : Vector3 = (player.global_transform.basis * 
	Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	
	var target : Vector3 = direction * base_speed
	
	vel_comp.accelerate_to(target, direction, delta)
	
	vel_comp.apply_gravity(delta)
