extends ConsoleCommand
class_name ClearCommand

func _init() -> void:
	name = "clear"
	help_text = "Clears the console"
	help_text_short = "Clears the console"

func run_command(args: Array[String]) -> String:
	DevConsole.instance.console_output.text = ""
	return ""
