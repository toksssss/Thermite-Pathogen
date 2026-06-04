extends WeaponState

const DEFAULT_ANIMATION_END : float = 1.375


@warning_ignore("unused_parameter")
func check_relevance(input: InputPackage) -> String:
	if works_longer_than(animation_duration):		# Change to current_weapon.is_cooldown
		return best_input_that_can_be_paid(input)
	return "okay"

@warning_ignore("unused_parameter")
func update(input: InputPackage, delta: float) -> void:
	pass

func on_enter_state() -> void:
	animation_duration = DEFAULT_ANIMATION_END / speed_multiplier
	
	var attack_data : AttackData = AttackData.new()
	attack_data.damage = 20.0
	melee_hurtbox.attack_data = attack_data
	
	melee_hurtbox.damage()


#func on_exit_state() -> void:
	# Delete later
	#melee_hurtbox.monitoring = false
