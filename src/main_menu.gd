extends Control
class_name MainMenu

const SCENE_PATH : String = "res://assets/main_menu/main_menu.tscn"

var start_game : Button
var settings : Button
var exit : Button
var settings_menu : SettingsMenu
var submenus : Control

func _ready() -> void:
	start_game = %StartGame
	start_game.button_down.connect(_on_start_game_pressed)
	settings = %Settings
	settings.button_down.connect(_on_settings_pressed)
	exit = %Exit
	exit.button_down.connect(_on_exit_pressed)
	settings_menu = $Submenus/SettingsMenu

static func create() -> MainMenu:
	var _menu : PackedScene = await PreloadManager.instance.load_scene_to_cache(SCENE_PATH)
	var menu : MainMenu = _menu.instantiate()
	return menu

func _on_start_game_pressed() -> void:
	await GameManager.instance.start_load_scene(await GameplayManager.create())

func _on_settings_pressed() -> void:
	settings_menu.visible = true

func _on_exit_pressed() -> void:
	GameManager.instance.quit()
