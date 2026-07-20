extends WeaponState

@warning_ignore("unused_parameter")
func check_relevance(input: InputPackage) -> String:
	if !current_weapon.is_cooldown:
		return best_input_that_can_be_paid(input)
	return &"okay"

func on_enter_state() -> void:
	var cooldown : float = animation_length / current_weapon.weapon_data.reload_speed_multiplier
	animation_speed = current_weapon.weapon_data.reload_speed_multiplier
	
	start_timer(cooldown)

func on_exit_state() -> void:
	current_weapon.reload()
