extends WeaponState

const ANIMATION_END : float = 0.5417

@warning_ignore("unused_parameter")
func check_relevance(input: InputPackage) -> String:
	if works_longer_than(ANIMATION_END):		# Change to current_weapon.is_cooldown
		return "idle"
	return "okay"

@warning_ignore("unused_parameter")
func update(input: InputPackage, delta: float) -> void:
	pass

func on_enter_state() -> void:
	current_weapon.attack(weapon_model)

func on_exit_state() -> void:
	pass
