extends WeaponState

@warning_ignore("unused_parameter")
func check_relevance(input: InputPackage) -> String:
	if input.combat_actions.has(&"reload"):
		return &"reload"
	
	if !current_weapon.is_cooldown:# Change to current_weapon.is_cooldown
		return best_input_that_can_be_paid(input)
	return &"okay"

func on_enter_state() -> void:
	var cooldown : float = 1 * 60 / current_weapon.weapon_data.fire_rate
	animation_speed = animation_length / cooldown

	start_timer(cooldown)

	current_weapon.attack(weapon_model, weapon_model.marker)
	current_weapon.pay_resource(self)

func on_exit_state() -> void:
	pass
