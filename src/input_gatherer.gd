extends Node
class_name InputGatherer

func gather_input() -> InputPackage:
	var new_input : InputPackage = InputPackage.new()

	# Move actions:
	
	if Input.is_action_just_pressed("btn_jump"):
		new_input.actions.append("jump")
	
	new_input.input_direction = Input.get_vector(
		"btn_walk_left",
		"btn_walk_right",
		"btn_walk_up",
		"btn_walk_down")
	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("walk")
	
	if new_input.actions.is_empty():
		new_input.actions.append("idle")
	
	# Combat actions:
	
	if Input.is_action_just_pressed("btn_attack"):
		new_input.combat_actions.append("fire")
	
	if Input.is_action_just_pressed("btn_reload"):
		new_input.combat_actions.append("reload")
	
	if new_input.combat_actions.is_empty():
		new_input.combat_actions.append("idle")
	
	return new_input
