extends Control
class_name SettingsMenu

var vsync_checkbox : CheckBox

var fullscreen_checkbox : CheckBox

var back_button : Button

func _ready() -> void:
	#vsync_checkbox = %Vsync
	#fullscreen_checkbox = %Fullscreen
	back_button = $Button
	back_button.button_down.connect(_on_back_button_down)
	
func _on_back_button_down() -> void:
	visible = false
