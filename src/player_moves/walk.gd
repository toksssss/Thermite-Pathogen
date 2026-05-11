extends Move

var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")

const SLIDE_THRESHOLD : float = 14.0

func check_relevance(input: InputPackage) -> String:
	if !player.is_on_floor():
		return "falling"
	
	if input.actions.has("crouch"):
		if player.velocity.length() >= SLIDE_THRESHOLD:
			return "slide"
	
	input.actions.sort_custom(moves_priority_sort)
	if input.actions[0] == "walk":
		return "okay"
	return input.actions[0]

func update(input: InputPackage, delta: float) -> void:
	velocity_by_input(input, delta)

func velocity_by_input(input: InputPackage, delta: float) -> void:
	var direction : Vector3 = (player.global_transform.basis * 
	Vector3(input.input_direction.x, 0, input.input_direction.y)).normalized()
	
	var target : Vector3 = direction * base_speed * walk_speed_multiplier
	
	vel_comp.accelerate_to(target, direction, delta)
