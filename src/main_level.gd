extends Node3D
class_name MainLevel

const SCENE_PATH : String = "uid://blovxxcqjxm0o"

var spawning_manager : SpawningManager
var level_timer : LevelTimer

static var instance : MainLevel:
	get:
		return LevelContainer.instance.current_level as MainLevel

static func create() -> MainLevel:
	var _level := await PreloadManager.instance.load_scene_to_cache(SCENE_PATH)
	var level := _level.instantiate()
	return level

func _ready() -> void:
	spawning_manager = %SpawningManager
	level_timer = %LevelTimer
