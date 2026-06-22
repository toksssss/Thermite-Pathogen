extends Node
class_name SpawningManager

enum STAGE
{
	ONE,
	TWO,
	THREE,
	FOUR,
	FIVE,
}

@export var stages : Dictionary[STAGE, float]

@export_category("Enemies")
@export var _weak_enemies: Array[PackedScene]
@export var _mid_enemies: Array[PackedScene]
@export var _strong_enemies: Array[PackedScene]
@export var _minibosses : Array[PackedScene]
@export var _bosses : Array[PackedScene]

var weak : Array[CharacterBody3D]
var mid : Array[CharacterBody3D]
var strong : Array[CharacterBody3D]
var minibosses : Array[CharacterBody3D]
var bosses : Array[CharacterBody3D]

#var terrain : Terrain3D

var navigation_region : NavigationRegion3D
var _mob_scene : PackedScene
var debug_mesh : MeshInstance3D
var timer : Timer

var p1 : Vector3
var p2 : Vector3

func _ready() -> void:
	_mob_scene = await PreloadManager.instance.load_scene_to_cache("res://assets/enemies/aed-p1/aed_p_1.tscn")
	#terrain = %Terrain
	timer = Timer.new()
	owner.add_child(timer)
	navigation_region = %SpawnTest
	_setup_points()
	_spawn()

func _setup_points() -> void:
	var bounds : AABB = navigation_region.get_bounds()
	p1 = bounds.position
	p2 = bounds.end

func _spawn() -> void:
	var _x := randf_range(p1.x, p2.x)
	#if terrain:
		#_y = terrain.data.get_height(_x, _z)
	#else
		#_y := p1.y
	var _y := p1.y
	var _z := randf_range(p1.z, p2.z)
	# Terrain
	# var _y := terrain.data.get_height(_x, _z)
	# ИЛИ
	#var region: Terrain3DRegion = terrain.data.get_regionp(global_position)
	#if region and not region.is_deleted():
		#var img: Image = region.get_height_map()
		#for y in img.get_height():
			 #for x in img.get_width():
				  #var height: float = img.get_pixel(x, y).r
	
	var _mob : AED_P1 = _mob_scene.instantiate()
	_mob.position = Vector3(_x, _y, _z)
	Utils.add_child_safe(_mob, owner)
	
	timer.start(3.0)
	await timer.timeout
	_spawn()
