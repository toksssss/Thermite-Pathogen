extends BaseLevel
class_name TerrainLevel

const SCENE_PATH : String = "uid://c2w2e4k4u3rch"

static var instance : TerrainLevel:
	get:
		return LevelContainer.instance.current_level as TerrainLevel

static func create() -> TerrainLevel:
	var _level := await PreloadManager.instance.load_scene_to_cache(SCENE_PATH)
	var level := _level.instantiate()
	return level

static func _create() -> TerrainLevel:
	var _level := load(SCENE_PATH)
	var level : TerrainLevel = _level.instantiate()
	return level

func _ready() -> void:
	super._ready()
	navigation_region = %NavigationRegion3D
