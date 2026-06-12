extends Node3D
class_name GameManager

static var instance : GameManager

var scene_container : RootSceneContainer

var preload_manager : PreloadManager

var loading_screen : LoadingScreen

var gameplay_scene : GameplayManager:
	get:
		return scene_container.current_scene as GameplayManager

var main_menu_node : MainMenu:
	get:
		return scene_container.current_scene as MainMenu

#var soundManager : SoundManager

func _ready() -> void:
	instance = self
	preload_manager = %PreloadManager
	scene_container = %RootSceneContainer
	loading_screen = %LoadingScreen
	game_startup_wrapper()

# В идеале запихивать на каждую стадию загрузки свою инициализацию систем 
# В sts2 к этому еще и накидывались логгеры
func game_startup_wrapper() -> void:
	game_startup()

func game_startup() -> void:
	launch_main_menu()

func launch_main_menu() -> void:
	var _menu : MainMenu = await MainMenu.create()
	scene_container.set_current_scene(_menu) 

func start_load_scene(level: Node3D) -> void:
	await loading_screen.fade_in()
	await load_scene(level)

func load_scene(level: Node3D) -> void:
	scene_container.set_current_scene(level)
	await loading_screen.fade_out()

func quit() -> void:
	get_tree().quit()
