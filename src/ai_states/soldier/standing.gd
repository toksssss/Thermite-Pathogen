extends AIMove

const ANIMATION_LENGTH : float = 1.0

var timer: Timer
var cooldown : float = 3.0
var is_cooldown: bool

func _ready() -> void:
	timer = Timer.new()
	timer.timeout.connect(func() -> void: is_cooldown = false)
	add_child.call_deferred(timer)

func check_transition(delta: float) -> String:
	if !player:
		return "okay"
	
	var distance := distance_to_player()
	if distance <= params.melee_trigger:
		return "melee"
	if distance >= params.follow_trigger:
		return "follow"
	
	if raycast.is_colliding():
		return "follow"

	return "okay"


func update(delta: float) -> void:
	rotate_character(player.global_position, params.rotate_speed * 2.0, delta)
	shoot()

func on_enter() -> void:
	pass


func on_exit() -> void:
	pass

func shoot() -> void:
	if is_cooldown:
		return
	weapon.attack(self, marker)
	timer.start(cooldown)
	is_cooldown = true
