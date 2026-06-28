extends AIMove

const ANIMATION_LENGTH : float = 1.5

@export var hurtbox: Hurtbox

func check_transition(delta: float) -> String:
	if works_longer_than(ANIMATION_LENGTH):
		return "idle"
	return "okay"


func update(delta: float) -> void:
	pass
 
func on_enter() -> void:
	var data: AttackData = AttackData.new()
	
	data.damage = params.melee_damage
	hurtbox.attack_data = data

func on_exit() -> void:
	pass
