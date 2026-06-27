extends Control
class_name PauseMenu

var continue_button : Button

var settings_button : Button

var exit_button : Button

var settings_menu : SettingsMenu

func _ready() -> void:
	visible = false
	settings_menu = %SettingsMenu
	continue_button = %BContinue
	continue_button.pressed.connect(_on_continue_pressed)
	settings_button = %BSettings
	settings_button.pressed.connect(_on_settings_pressed)
	exit_button = %BExit
	exit_button.pressed.connect(_on_exit_pressed)

func open() -> void:
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	mouse_filter = Control.MOUSE_FILTER_STOP
	GameplayManager.instance.ui_counter += 1
 
func close() -> void:
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	GameplayManager.instance.ui_counter -= 1

func _on_continue_pressed() -> void:
	GameplayManager.instance.close_pause_menu()

func _on_settings_pressed() -> void:
	settings_menu.visible = true

func _on_exit_pressed() -> void:
	#RootSceneContainer.instance.set_current_scene(await MainMenu.create())
	GameManager.instance.start_load_scene(await MainMenu.create())
