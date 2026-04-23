extends WeaponState

const ANIMATION_END : float = 2.3333

@warning_ignore("unused_parameter")
func check_relevance(input: InputPackage) -> String:
	if works_longer_than(ANIMATION_END):
		return "idle"
	return "okay"

@warning_ignore("unused_parameter")
func update(input: InputPackage, delta: float) -> void:
	print("Reloading")

func on_enter_state() -> void:
	print("Start Reload")

func on_exit_state() -> void:
	print("End reloading")
