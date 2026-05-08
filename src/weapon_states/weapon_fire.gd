extends WeaponState

const ANIMATION_END : float = 0.5417

@warning_ignore("unused_parameter")
func check_relevance(input: InputPackage) -> String:
	
	if works_longer_than(animation_duration):		# Change to current_weapon.is_cooldown
		return best_input_that_can_be_paid(input)
	return "okay"

func on_enter_state() -> void:
	animation_duration = ANIMATION_END / speed_multiplier
	
	current_weapon.attack(weapon_model)
	current_weapon.pay_resource(self)

func on_exit_state() -> void:
	pass
