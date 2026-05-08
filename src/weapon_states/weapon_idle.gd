extends WeaponState

func check_relevance(input: InputPackage) -> String:
	# Хардкод, но бля, мне похуй
	# Можно сделать комбо
	
	if input.combat_actions.has("fire")  and current_weapon._current_bullets == 0:
		return "reload"
	
	if input.combat_actions.has("reload") and (current_weapon._current_bullets == 
	current_weapon.weapon_data.bullet_capacity):
		return "okay"
	
	return best_input_that_can_be_paid(input)

#func update(input: InputPackage, delta: float) -> void:
	#pass
