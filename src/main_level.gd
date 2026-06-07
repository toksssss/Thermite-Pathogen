extends Node3D
class_name MainLevel

const SCENE_PATH : String = "res://assets/main/main_level.tscn"

static var instance : MainLevel:
	get:
		return GameManager.instance.main_level_node

static func create() -> MainLevel:
	var _level : PackedScene = await PreloadManager.instance.load_scene_to_cache("res://assets/main/main_level.tscn")
	var level : MainLevel = _level.instantiate()
	return level
