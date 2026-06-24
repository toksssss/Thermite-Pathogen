extends Node
class_name SpawningManager

static var instance: SpawningManager:
	get:
		return MainLevel.instance.spawning_manager

#var terrain : Terrain3D

var navigation_region : NavigationRegion3D

var p1 : Vector3
var p2 : Vector3

func _ready() -> void:
	#terrain = %Terrain
	# TODO: передвинуть в MainLevel
	navigation_region = %SpawnTest
	_setup_points()

func _setup_points() -> void:
	var bounds : AABB = navigation_region.get_bounds()
	p1 = bounds.position
	p2 = bounds.end

func spawn_mob(mob: Node3D) -> void:
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
	
	mob.position = Vector3(_x, _y, _z)
	Utils.add_child_safe(mob, owner)
