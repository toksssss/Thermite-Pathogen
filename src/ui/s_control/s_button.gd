extends Button
class_name SButton

func _ready() -> void:
	button_down.connect(_on_button_down)
	mouse_entered.connect(_on_mouse_entered)

func _on_button_down() -> void:
	SfxCmd.play_sfx_by_guid(SfxGuid.ui_click)

func _on_mouse_entered() -> void:
	SfxCmd.play_sfx_by_guid(SfxGuid.ui_hover)
