extends Control
class_name FullscreenCheckBox

var check_box : CheckBox

func _ready() -> void:
	check_box = %CheckBox
	check_box.button_up.connect(_on_fullscreen_enable)
	check_box.button_down.connect(_on_fullscreen_disable)

func _on_fullscreen_enable() -> void:
	fullscreen(true)

func _on_fullscreen_disable() -> void:
	fullscreen(false)

func fullscreen(flag: bool) -> void:
	if flag:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
