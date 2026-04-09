extends Move

@export var jump_velocity : float = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func check_relevance(input: InputPackage) -> String:
	if player.is_on_floor():
		input.actions.sort_custom(moves_priority_sort)
		return input.actions[0]
	return "okay"

@warning_ignore("unused_parameter")
func update(input: InputPackage, delta: float) -> void:
	player.velocity.y -= gravity * delta
	player.move_and_slide()

func on_enter_state() -> void:
	player.velocity.y += jump_velocity
