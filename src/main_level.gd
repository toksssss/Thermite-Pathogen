extends Node3D
class_name MainLevel

const SCENE_PATH : String = "uid://blovxxcqjxm0o"

var navigation_region : NavigationRegion3D

static var instance : MainLevel:
	get:
		return LevelContainer.instance.current_level as MainLevel

static func create() -> MainLevel:
	var _level := await PreloadManager.instance.load_scene_to_cache(SCENE_PATH)
	var level := _level.instantiate()
	return level

func _ready() -> void:
	navigation_region = %SpawnTest
