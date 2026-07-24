extends Control
class_name VSyncCheckbox

var check_box : CheckBox

func _ready() -> void:
	check_box = %CheckBox
	check_box.toggled.connect(set_vsync)
	check_box.button_pressed = DisplayServer.window_get_vsync_mode()

func set_vsync(flag: bool) -> void:
	if flag:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
