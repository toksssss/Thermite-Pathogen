extends WeaponState

const ANIMATION_END : float = 0.9167

@warning_ignore("unused_parameter")
func check_relevance(input: InputPackage) -> String:
	if works_longer_than(ANIMATION_END):		# Change to current_weapon.is_cooldown
		return best_input_that_can_be_paid(input)
	return "okay"

@warning_ignore("unused_parameter")
func update(input: InputPackage, delta: float) -> void:
	pass

func on_enter_state() -> void:
	var attack_data : AttackData = AttackData.new()
	attack_data.damage = 10
	melee_hurtbox.attack_data = attack_data
	melee_hurtbox.monitoring = true

func on_exit_state() -> void:
	melee_hurtbox.monitoring = false
