extends Node
class_name InputGatherer

var mouse_motion : Vector2

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_motion = (event as InputEventMouseMotion).relative

func gather_input() -> InputPackage:
	var new_input : InputPackage = InputPackage.new()
	
	# Mouse movement:
	new_input.mouse_motion = mouse_motion
	mouse_motion = Vector2(0, 0)
	
	# Move actions:
	
	if Input.is_action_just_pressed("btn_jump"):
		new_input.actions.append("jump")
	
	if Input.is_action_pressed("btn_crouch"):
		new_input.actions.append("crouch")
	
	new_input.input_direction = Input.get_vector(
		"btn_walk_left",
		"btn_walk_right",
		"btn_walk_up",
		"btn_walk_down")
	if new_input.input_direction != Vector2.ZERO:
		new_input.actions.append("walk")
	
	if new_input.actions.is_empty():
		new_input.actions.append("idle")
	
	# Secondary actions (heal, throw item etc.):
	
	if Input.is_action_just_pressed("btn_throw"):
		new_input.secondary_actions.append("throw")
	
	# Ability actions (hotbar):
	if Input.is_action_just_pressed("btn_ability_prime"):
		new_input.ability_actions.append("ability_prime")
	
	if Input.is_action_just_pressed("btn_ability_1"):
		new_input.ability_actions.append("ability_1")

	if Input.is_action_just_pressed("btn_ability_2"):
		new_input.ability_actions.append("ability_2")

	if Input.is_action_just_pressed("btn_ability_3"):
		new_input.ability_actions.append("ability_3")

	if Input.is_action_just_pressed("btn_ability_4"):
		new_input.ability_actions.append("ability_4")

	# Combat actions (Main weapon):

	if Input.is_action_just_pressed("btn_attack"):
		new_input.combat_actions.append("fire")
	
	if Input.is_action_just_pressed("btn_reload"):
		new_input.combat_actions.append("reload")
	
	if Input.is_action_just_pressed("btn_melee"):
		new_input.combat_actions.append("melee")
	
	# Проще просто всегда добавлять Idle, в ином случае выбивает ошибку в resource_that_can_be_paid
	#if new_input.combat_actions.is_empty():
		#new_input.combat_actions.append("idle")
	new_input.combat_actions.append("idle")
	return new_input
