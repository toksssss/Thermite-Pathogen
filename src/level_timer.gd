extends Node
class_name LevelTimer

static var instance : LevelTimer:
	get:
		return GameplayManager.instance.level_timer

#var start_level_msec : int
#var current_level_msec : int:
	#get:
		#return Time.get_ticks_msec() - start_level_msec
	#set(v):
		#pass

var is_paused : bool = true

var current_level_timer : float = 0

var current_level_sec : int:
	get:
		@warning_ignore("narrowing_conversion")
		return current_level_timer
	set(v):
		pass

var current_level_min : int:
	get:
		@warning_ignore("integer_division")
		return current_level_min % 60
	set(v):
		pass

func _ready() -> void:
	LevelContainer.instance.level_changed.connect(func() -> void: current_level_timer = 0)

func _physics_process(delta: float) -> void:
	if !is_paused:
		current_level_timer += delta

func start_timer() -> void:
	is_paused = false
