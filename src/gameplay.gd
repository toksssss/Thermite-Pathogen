extends Node3D
class_name GameplayManager

const SCENE_PATH : String = "res://assets/game/gameplay.tscn"

signal ui_opened

signal ui_closed

signal game_paused

signal game_unpaused

static var instance : GameplayManager:
	get:
		if GameManager.instance == null:
			return null
		return GameManager.instance.gameplay_scene

var level_container : LevelContainer

var game_ui : GameUI

var stage_machine : StageMachine

var spawning_manager : SpawningManager

var level_timer : LevelTimer

var ui_counter : int:
	get:
		return ui_counter
	set(v):
		if v == 0:
			ui_closed.emit()
		if v > 0:
			ui_opened.emit()
		ui_counter = v

func _enter_tree() -> void:
	level_container = %LevelContainer
	game_ui = %GameUI
	stage_machine = %StageMachine
	spawning_manager = %SpawningManager
	level_timer = %LevelTimer

func _ready() -> void:
	ui_opened.connect(func() -> void: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE)
	ui_closed.connect(func() -> void: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED)
	start_main_level()

static func create() -> GameplayManager:
	var _scene := await PreloadManager.instance.load_scene_to_cache(SCENE_PATH)
	var scene := _scene.instantiate()
	return scene

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause_menu"):
		if !game_ui.pause_menu.visible:
			open_pause_menu()
		else:
			close_pause_menu()

func open_pause_menu() -> void:
	game_ui.pause_menu.open()
	game_paused.emit()
	#GameManager.Instance.set_pause(true)
	#get_tree().paused = true

func close_pause_menu() -> void:
	game_ui.pause_menu.close()
	game_unpaused.emit()
	 #GameManager.instance.set_pause(false)
	 #get_tree().paused = false

#func start_main_level() -> void:
	#await LoadingScreen.instance.fade_in()
	#level_container.set_current_level(await MainLevel.create())
	#await LoadingScreen.instance.fade_out()

func start_main_level() -> void:
	await set_current_level(await MainLevel.create())

func set_current_level(level: Node) -> void:
	await LoadingScreen.instance.fade_in()
	level_container.set_current_level(level)
	await LoadingScreen.instance.fade_out()
