extends Node3D
class_name GameplayManager

const SCENE_PATH : String = "res://assets/game/gameplay.tscn"

static var instance : GameplayManager:
	get:
		return GameManager.instance.gameplay_scene

var level_container : LevelContainer

var game_ui : Control

func _ready() -> void:
	level_container = %LevelContainer
	game_ui = %GameUI
	start_main_level()

static func create() -> GameplayManager:
	var _scene := await PreloadManager.instance.load_scene_to_cache(SCENE_PATH)
	var scene := _scene.instantiate()
	return scene

#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("pause_menu"):
		#if game_ui.pause_menu.is_opened:
			#open_pause_menu()
		#else:
			#close_pause_menu()

#func open_pause_menu() -> void:
	#game_ui.pause_menu.open()
	# Game.Instance.set_pause(true)
	#get_tree().paused = true

#func close_pause_menu() -> void:
	#game_ui.pause_menu.close()
	# Game.instance.set_pause(false)
	# get_tree().paused = false

func start_main_level() -> void:
	level_container.set_current_level(await MainLevel.create())
