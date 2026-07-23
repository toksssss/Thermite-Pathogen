extends Node3D
class_name GameplayManager

const SCENE_PATH : String = "res://assets/game/gameplay.tscn"

signal game_paused

signal game_unpaused

var init_level : BaseLevel

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

func _enter_tree() -> void:
	level_container = %LevelContainer
	game_ui = %GameUI
	stage_machine = %StageMachine
	spawning_manager = %SpawningManager
	level_timer = %LevelTimer

func _ready() -> void:
	if init_level:
		set_current_level(init_level)
	GameManager.instance.ui_opened.connect(func() -> void: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE)
	GameManager.instance.ui_closed.connect(func() -> void: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED)

static func create(level: BaseLevel = null) -> GameplayManager:
	var _scene := await PreloadManager.instance.load_scene_to_cache(SCENE_PATH)
	var scene : GameplayManager = _scene.instantiate()
	scene.init_level = level
	return scene

static func _create() -> GameplayManager:
	var _scene := load(SCENE_PATH)
	var scene : GameplayManager= _scene.instantiate()
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
	set_pause(true)

func close_pause_menu() -> void:
	game_ui.pause_menu.close()
	game_unpaused.emit()
	set_pause(false)

func start_main_level() -> void:
	set_current_level(await MainLevel.create())

func set_current_level(level: BaseLevel) -> void:
	level_container.set_current_level(level)

func set_pause(v: bool) -> void:
	get_tree().paused = v
