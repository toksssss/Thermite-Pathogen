extends WeaponState

@warning_ignore("unused_parameter")
func check_relevance(input: InputPackage) -> String:
	if !current_weapon.is_cooldown:
		return best_input_that_can_be_paid(input)
	return "okay"

@warning_ignore("unused_parameter")
func update(input: InputPackage, delta: float) -> void:
	pass

func on_enter_state() -> void:
	var cooldown : float = animation_length / current_weapon.weapon_data.melee_speed_multiplier
	animation_speed = current_weapon.weapon_data.melee_speed_multiplier
	
	start_timer(cooldown)
	
	var attack_data : AttackData = AttackData.new()
	attack_data.damage = 20.0
	melee_hurtbox.attack_data = attack_data
	
	melee_hurtbox.damage()
