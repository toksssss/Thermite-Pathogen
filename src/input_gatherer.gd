extends Node
class_name InputGatherer

func gather_input() -> InputPackage:
	var new_input : InputPackage = InputPackage.new()
	
	if Input.is_action_just_pressed("jump"):
		new_input.actions.append("jump")
	
	new_input.input_direction = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("walk")
	
	if new_input.actions.is_empty():
		new_input.actions.append("idle")
	
	return new_input
