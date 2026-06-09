extends Control
class_name VSyncCheckbox

var check_box : CheckBox

func _ready() -> void:
	check_box = %CheckBox
	check_box.toggled.connect(_on_vsync_ticked)

func _on_vsync_ticked(flag: bool) -> void:
	if flag:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	
