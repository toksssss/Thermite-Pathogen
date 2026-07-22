extends WeaponState

var vfx : Vfx

func _ready() -> void:
	vfx = (await PreloadManager.instance.load_scene_to_cache("uid://btyw1ns26aqsv")).instantiate()
	Utils.add_child_safe(vfx, muzzle)

func check_relevance(input: InputPackage) -> String:
	if !current_weapon.is_cooldown:
		return best_input_that_can_be_paid(input)
	return &"okay"

func on_enter_state() -> void:
	print("Charged attack")
	
	animation_speed = 1.0
	
	start_timer(animation_length)
	
	current_weapon.alternative_attack(weapon_model, weapon_model.marker)
	current_weapon.pay_resource(self)
	
	head_movement.add_trauma(0.7)
	vfx.play_vfx()
	

func on_exit_state() -> void:
	current_weapon.is_charged = false
