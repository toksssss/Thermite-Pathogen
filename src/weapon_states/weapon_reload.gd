extends WeaponState

const ANIMATION_END : float = 2.3333

@warning_ignore("unused_parameter")
func check_relevance(input: InputPackage) -> String:
	if works_longer_than(ANIMATION_END):
		return best_input_that_can_be_paid(input)
	return "okay"

func on_enter_state() -> void:
	pass

func on_exit_state() -> void:
	resources.reload()
