extends ConsoleCommand
class_name QuitCommand

func _init() -> void:
	name = "quit"
	help_text = "Quits the game"
	help_text_short = "Quits the game"

func run_command(args: Array[String]) -> String:
	GameManager.instance.quit()
	return ""
