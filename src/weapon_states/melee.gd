extends WeaponState

const DEFAULT_ANIMATION_END : float = 1.375

var _base_timer : float = 0.1
var timer : float

@warning_ignore("unused_parameter")
func check_relevance(input: InputPackage) -> String:
	if works_longer_than(animation_duration):		# Change to current_weapon.is_cooldown
		return best_input_that_can_be_paid(input)
	return "okay"

@warning_ignore("unused_parameter")
func update(input: InputPackage, delta: float) -> void:
	if timer > 0:
		timer -= delta
	else:
		melee_hurtbox.monitoring = false

func on_enter_state() -> void:
	animation_duration = DEFAULT_ANIMATION_END / speed_multiplier
	
	timer = _base_timer
	
	var attack_data : AttackData = AttackData.new()
	attack_data.damage = 10
	melee_hurtbox.attack_data = attack_data
	melee_hurtbox.monitoring = true

#func on_exit_state() -> void:
	# Delete later
	#melee_hurtbox.monitoring = false
