extends AIMove

@export var melee_trigger : float = 10.0
@export var idle_trigger : float = 30.0
@export var speed : float = 2.0
@export var rotate_speed : float = 6.0

var cooldown : float = 0.5
var is_cooldown : bool
var timer : Timer

func _ready() -> void:
	timer = Timer.new()
	timer.timeout.connect(func() -> void: is_cooldown = false)
	add_child.call_deferred(timer)

func check_transition(delta: float) -> String:
	var distance : float = character.global_position.distance_to(player.global_position)
	if distance <= melee_trigger:
		return "melee"
	if distance >= idle_trigger:
		return "idle"
	return "okay"


func update(delta: float) -> void:
	follow_target(delta)
	rotate_character(player.global_position, rotate_speed, delta)
	shoot()


func on_enter() -> void:
	pass

func on_exit() -> void:
	nav_agent.velocity = Vector3.ZERO


func follow_target(delta: float) -> void:
	nav_agent.target_position = player.global_position
	
	if nav_agent.is_navigation_finished():
		character.velocity = Vector3.ZERO
		return
	
	var destination := nav_agent.get_next_path_position()
	var direction := (destination - character.global_position).normalized()
	nav_agent.velocity = direction * speed

func shoot() -> void:
	if is_cooldown:
		return
	weapon.attack(self, marker)
	timer.start(cooldown)
	is_cooldown = true
