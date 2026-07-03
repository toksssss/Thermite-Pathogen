extends Node
class_name SpawningManager

static var instance: SpawningManager:
	get:
		return GameplayManager.instance.spawning_manager

var terrain : Terrain3D

var navigation_region : NavigationRegion3D

var p1 : Vector3
var p2 : Vector3

func _ready() -> void:
	LevelContainer.instance.level_changed.connect.call_deferred(_on_level_changed)

func _setup_points() -> void:
	var bounds : AABB = navigation_region.get_bounds()
	p1 = bounds.position
	p2 = bounds.end

func spawn_mob(mob: Node3D) -> void:
	var _x : float
	var _y : float
	var _z : float
	
	_x = randf_range(p1.x, p2.x)
	_z = randf_range(p1.z, p2.z)
	if !terrain:
		_y = p1.y
	else:
		_y = terrain.data.get_height(Vector3(_x, 0, _z))

	# ИЛИ
	#var region: Terrain3DRegion = terrain.data.get_regionp(global_position)
	#if region and not region.is_deleted():
		#var img: Image = region.get_height_map()
		#for y in img.get_height():
			 #for x in img.get_width():
				  #var height: float = img.get_pixel(x, y).r
	
	mob.position = Vector3(_x, _y, _z)
	Utils.add_child_safe(mob, LevelContainer.instance.current_level)

func _on_level_changed() -> void:
	terrain = LevelContainer.instance.current_level.terrain
	navigation_region = LevelContainer.instance.current_level.navigation_region
	_setup_points()
