extends AIMove

var cooldown : float = 0.5
var is_cooldown : bool
var timer : Timer

func _ready() -> void:
	timer = Timer.new()
	timer.timeout.connect(func() -> void: is_cooldown = false)
	add_child(timer)

func check_transition(delta: float) -> String:
	if !player:
		return "idle"
	
	var distance : float = distance_to_player()
	if distance <= params.melee_trigger:
		if raycast.is_colliding():
			return "melee"
	if distance >= params.idle_trigger:
		return "idle"
	return "okay"


func update(delta: float) -> void:
	follow_target(params.speed, delta)
	rotate_character(player.global_position, params.rotate_speed, delta)
	shoot()

func on_enter() -> void:
	pass

func on_exit() -> void:
	nav_agent.velocity = Vector3.ZERO

func shoot() -> void:
	if is_cooldown:
		return
	weapon.attack(self, marker)
	timer.start(cooldown)
	is_cooldown = true
