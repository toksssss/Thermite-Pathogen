extends BaseLevel

# use UID instead path
const SCENE_PATH : String = ""

static var instance : BaseLevel:
	get:
		return LevelContainer.instance.current_level as BaseLevel

static func create() -> BaseLevel:
	var _level := await PreloadManager.instance.load_scene_to_cache(SCENE_PATH)
	var level := _level.instantiate()
	return level
