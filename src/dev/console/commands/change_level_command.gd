extends ConsoleCommand
class_name ChangelevelCommand

var levels : Dictionary[String, Object] = {
	"main": MainLevel,
	"terrain": TerrainLevel,
}

func _init() -> void:
	name = "changelevel"
	help_text = "Changes current level at gameplay node."
	help_text_short = "Change level"

func run_command(args: Array[String]) -> String:
	if len(args) == 0:
		return "Provide at least 1 argument\n"
	var new_level : String = args[0]
	if levels.has(new_level):
		var callable : Callable = Callable(levels[new_level], "create")
		if GameplayManager.instance == null:
			DevConsole.instance.console_print_log("GameplayManager is not at the scene. Loading GameplayManager first\n")
			GameManager.instance.start_load_scene(await GameplayManager.create())
			await GameManager.instance.scene_loaded
		GameplayManager.instance.set_current_level(await callable.call() as Node)
	else:
		return "Level is not found. Failed\n"
	return "Level changed to %s\n" % new_level
