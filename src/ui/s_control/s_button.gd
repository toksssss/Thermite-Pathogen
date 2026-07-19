extends Button
class_name SButton

func _ready() -> void:
	button_down.connect(_on_button_down)
	mouse_entered.connect(_on_mouse_entered)
	

func _on_button_down() -> void:
	Sfx.play_sfx("{36c13bdb-0d95-4321-a5a0-00f4e59e8642}")

func _on_mouse_entered() -> void:
	Sfx.play_sfx("{9db732eb-a2f8-4f4c-9210-218cbb9c2e33}")
