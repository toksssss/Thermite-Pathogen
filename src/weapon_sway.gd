extends Node
class_name WeaponSway

#@export var rig : Node3D
@onready var player : Player = $"../../.."
@onready var model : WeaponModel = $".." 
var mouse_movement : Vector2

# Called when the node enters the scene tree for the first time.

func sway(strategy: WeaponStrategy, input: InputPackage, delta: float) -> void:
	var stats : WeaponResource = strategy.weapon_resource
	
	mouse_movement = input.mouse_motion.clamp(stats.sway_min, stats.sway_max)
	
	# Lerp position
	var temp_position : Vector3 = model.current_weapon_viewmodel.position
	
	temp_position.x = lerp(temp_position.x, stats.position.x - 
	(input.input_direction.x * player.velocity.length() * stats.sway_amount_position) * delta, stats.sway_speed_position)
	
	temp_position.y = lerp(temp_position.y, stats.position.y + 
	(player.velocity.y * 2 * stats.sway_amount_position) * delta, stats.sway_speed_position)
	
	# Lerp rotation
	var temp_rotation : Vector3 = model.current_weapon_viewmodel.rotation_degrees
	
	temp_rotation.x = lerp(temp_rotation.x, stats.rotation.x - 
	(mouse_movement.y * stats.sway_amount_rotation) * delta, stats.sway_speed_position)
	
	temp_rotation.y = lerp(temp_rotation.y, stats.rotation.y + 
	(mouse_movement.x * stats.sway_amount_rotation) * delta, stats.sway_speed_position)
	
	model.current_weapon_viewmodel.position = temp_position
	#model.current_weapon_viewmodel.rotation_degrees = temp_rotation
