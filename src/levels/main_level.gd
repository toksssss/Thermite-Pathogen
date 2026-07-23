extends BaseLevel
class_name MainLevel

const SCENE_PATH : String = "uid://blovxxcqjxm0o"

static var instance : MainLevel:
	get:
		return LevelContainer.instance.current_level as MainLevel

static func create() -> MainLevel:
	var _level := await PreloadManager.instance.load_scene_to_cache(SCENE_PATH)
	var level := _level.instantiate()
	return level

static func _create() -> MainLevel:
	var _level := load(SCENE_PATH)
	var level : MainLevel = _level.instantiate()
	return level

func _ready() -> void:
	super._ready()
	navigation_region = %SpawnTest
