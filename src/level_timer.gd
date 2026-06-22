extends Node
class_name LevelTimer

var start_level_msec : float
var current_level_msec : float:
	get:
		return Time.get_ticks_msec() - start_level_msec
	set(v):
		pass

func _ready() -> void:
	start_level_msec = Time.get_ticks_msec()
