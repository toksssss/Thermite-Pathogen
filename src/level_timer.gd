extends Node
class_name LevelTimer

static var instance : LevelTimer:
	get:
		return GameplayManager.instance.level_timer

var start_level_msec : int
var current_level_msec : int:
	get:
		return Time.get_ticks_msec() - start_level_msec
	set(v):
		pass

var current_level_sec : int:
	get:
		@warning_ignore("integer_division")
		return (current_level_msec / 1000) % 60
	set(v):
		pass

var current_level_min : int:
	get:
		@warning_ignore("integer_division")
		return (current_level_msec / 60000) % 60
	set(v):
		pass

func _ready() -> void:
	start_level_msec = Time.get_ticks_msec()
