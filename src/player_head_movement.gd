extends Node

@onready var player : Player = $"../.."
@export var camera : Camera3D
@onready var stand_head_height : float = player.head.position.y

@export_category("Effects")
@export var enable_tilt : bool = true

@export_group("Crouching")
@export var crouch_depth : float = 0.4

@export_group("Timings")
@export var lerp_time : float = 12

@export_group("Run Tilt")
@export var run_pitch : float = 0.05 # Degrees
@export var run_roll : float = 0.05 # Degrees
@export var max_pitch : float = 0.5 # Degrees
@export var max_roll : float = 1.5 # Degrees

func _physics_process(delta: float) -> void:
	check_crouching(delta)
	calculate_view_offset(delta)

func check_crouching(delta: float) -> void:
	var temp_head_height : float = player.head.position.y
	if player.is_crouching:
		temp_head_height = lerp(temp_head_height, stand_head_height - crouch_depth, delta * lerp_time)
	else:
		temp_head_height = lerp(temp_head_height, stand_head_height, delta * lerp_time)
	player.head.position.y = temp_head_height

func calculate_view_offset(_delta) -> void:
	var velocity = player.velocity
	
	var angles = Vector3.ZERO
	
	if enable_tilt:
		var forward : Vector3 = camera.global_transform.basis.z
		var right : Vector3 = camera.global_transform.basis.x
		
		var forward_dot : float = velocity.dot(forward)
		var forward_tilt : float = clampf(forward_dot * deg_to_rad(run_pitch), deg_to_rad(-max_pitch), deg_to_rad(max_pitch))
		angles.x += forward_tilt
		
		var right_dot : float = velocity.dot(right)
		var side_tilt : float = clampf(right_dot * deg_to_rad(run_roll), deg_to_rad(-max_roll), deg_to_rad(max_roll))
		angles.z -= side_tilt
	camera.rotation = angles
