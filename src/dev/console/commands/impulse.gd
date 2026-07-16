extends ConsoleCommand
class_name ImpulseCommand

const WEAPON_RESOURCES : Dictionary[int, String] = {
	100 : "",
	101 : "",
}

func _init() -> void:
	name = "impulse"
	help_text = "Shortcut dev command. Use 'impulse <num>'"
	help_text_short = "Shortcuts"

func run_command(args: Array[String]) -> String:
	if len(args) == 0:
		return "No arguments. Skipping\n"
	match args[0]:
		100:
			# default weapon
			return "100\n"
		101:
			# dev weapon
			return "101\n"
		_:
			return "Wrong argument. Failed\n"
