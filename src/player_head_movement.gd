extends Node
class_name HeadMovementComponent

@onready var player : Player = $".."
@export var camera : Camera3D
@onready var stand_head_height : float = player.head.position.y

@export_category("Effects")
@export var enable_tilt : bool = true
@export var enable_shake : bool = true

@export_group("Crouching")
@export var crouch_depth : float = 0.4

@export_group("Timings")
@export var lerp_time : float = 12

@export_group("Run Tilt")
@export var t_run_pitch : float = 0.05 # Degrees
@export var t_run_roll : float = 0.05 # Degrees
@export var t_max_pitch : float = 0.5 # Degrees
@export var t_max_roll : float = 1.5 # Degrees

@export_group("Camera Shake")
@export_subgroup("Trauma")
@export var decay : float = 0.8
@export var trauma_power : int = 3

@export_subgroup("Rotation")
@export var s_enable_rotation : bool = true	
@export var s_max_pitch : float = 3.0
@export var s_max_yaw : float = 3.0
@export var s_max_roll : float = 3.0

@export_subgroup("Offset")
@export var s_enable_offset : bool = true
@export var s_max_offset : float = 0.1

var angles : Vector3
var trauma : float = 0.0
var noise := FastNoiseLite.new()
var noise_y : int = 0

func _ready() -> void:
	randomize()
	noise.seed = randi()
	noise.frequency = 0.3
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX

func add_trauma(_val: float) -> void:
	trauma = min(trauma + _val, 1.0)

func add_trauma_if_less_than(_val: float, _max: float) -> void:
	if trauma < _max:
		trauma = min(trauma + _val, _max)
		trauma = min(trauma, 1.0)

func _process(delta: float) -> void:
	if enable_shake && trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

func _physics_process(delta: float) -> void:
	check_crouching(delta)
	calculate_view_offset(delta)

func shake() -> void:
	var amount : float = pow(trauma, trauma_power)
	noise_y += 1
	
	if s_enable_rotation:
		var pitch : float = deg_to_rad(s_max_pitch) * amount * noise.get_noise_2d(noise_y + 1, noise_y)
		var yaw : float = deg_to_rad(s_max_yaw) * amount * noise.get_noise_2d(noise_y + 2 , noise_y)
		var roll : float = deg_to_rad(s_max_roll) * amount * noise.get_noise_2d(noise_y + 3, noise_y)
		camera.rotation.x = angles.x + pitch
		camera.rotation.y = angles.y + yaw
		camera.rotation.z = angles.z + roll
	
	if s_enable_offset:
		var offset_x : float = s_max_offset * amount * noise.get_noise_2d(noise_y + 4, noise_y)
		var offset_y : float = s_max_offset * amount *  noise.get_noise_2d(noise_y + 5, noise_y)
		camera.position.x = offset_x
		camera.position.y = offset_y

func check_crouching(delta: float) -> void:
	var temp_head_height : float = player.head.position.y
	if player.is_crouching:
		temp_head_height = lerp(temp_head_height, stand_head_height - crouch_depth, delta * lerp_time)
	else:
		temp_head_height = lerp(temp_head_height, stand_head_height, delta * lerp_time)
	player.head.position.y = temp_head_height

func calculate_view_offset(_delta: float) -> void:
	angles = Vector3.ZERO
	if enable_tilt:
		var velocity : Vector3 = player.velocity
		var forward : Vector3 = camera.global_transform.basis.z
		var right : Vector3 = camera.global_transform.basis.x
		
		var forward_dot : float = velocity.dot(forward)
		var forward_tilt : float = clampf(forward_dot * deg_to_rad(t_run_pitch), deg_to_rad(-t_max_pitch), deg_to_rad(t_max_pitch))
		angles.x += forward_tilt
		
		var right_dot : float = velocity.dot(right)
		var side_tilt : float = clampf(right_dot * deg_to_rad(t_run_roll), deg_to_rad(-t_max_roll), deg_to_rad(t_max_roll))
		angles.z -= side_tilt
	camera.rotation = angles
