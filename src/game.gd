extends Node3D
class_name GameManager

static var instance : GameManager

var scene_container : RootSceneContainer

var main_level_node : MainLevel:
	get:
		return scene_container.current_scene as MainLevel

var main_menu_node : MainMenu:
	get:
		return scene_container.current_scene as MainMenu

#var soundManager : SoundManager

func _ready() -> void:
	instance = self
	scene_container = %RootSceneContainer
	game_startup_wrapper()

# В идеале запихивать на каждую стадию загрузки свою инициализацию систем 
# В sts2 к этому еще и накидывались логгеры
func game_startup_wrapper() -> void:
	game_startup()

func game_startup() -> void:
	launch_main_menu()

func launch_main_menu() -> void:
	var _menu : MainMenu = MainMenu.create()
	scene_container.set_current_scene(_menu) 

func load_level() -> void:
	scene_container.set_current_scene(MainLevel.create())

func quit() -> void:
	get_tree().quit()
