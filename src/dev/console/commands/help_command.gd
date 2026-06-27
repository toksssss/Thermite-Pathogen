extends ConsoleCommand
class_name HelpCommand

func _init() -> void:
	name = "help"
	help_text = "Prints information about all commands. Use 'help <cmd>' to see info about specific command"
	help_text_short = "Prints commands info"

func run_command(args: Array[String]) -> String:
	if len(args) > 0:
		if DevConsoleManager.instance.command_dict.has(args[0]):
			var command: ConsoleCommand = DevConsoleManager.instance.command_dict[args[0]]
			return "%s - %s\n" % [command.name, command.help_text]
		else:
			return "Unknown command. Skipping" % args[0]
	
	var a : String = "Type 'help' to see this list:\n\n"
	for command: ConsoleCommand in DevConsoleManager.instance.command_dict.values():
		a += "%s - %s\n" % [command.name, command.help_text] 
	a += "\nType 'help <cmd>' to see more information about a specific command. \n"

	return a
