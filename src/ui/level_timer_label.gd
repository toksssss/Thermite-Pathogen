extends Label

var level_timer : LevelTimer

func _ready() -> void:
	level_timer = LevelTimer.instance
	label_settings = LabelSettings.new()
	label_settings.font_size = 64

func _physics_process(delta: float) -> void:
	text = "%d:%d" % [level_timer.current_level_min, level_timer.current_level_sec]
