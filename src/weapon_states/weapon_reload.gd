extends WeaponState

const ANIMATION_END : float = 2.3333

@warning_ignore("unused_parameter")
func check_relevance(input: InputPackage) -> String:
	if works_longer_than(animation_duration):
		return best_input_that_can_be_paid(input)
	return "okay"

func on_enter_state() -> void:
	animation_duration = ANIMATION_END / speed_multiplier

func on_exit_state() -> void:
	current_weapon.reload()
