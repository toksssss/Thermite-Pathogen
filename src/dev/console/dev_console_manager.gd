class_name DevConsoleManager

static var instance: DevConsoleManager:
	get:
		return DevConsole.instance.console_manager

var command_dict : Dictionary[String, ConsoleCommand] = {}

var command_history : Array[String]
var command_history_index : int = -1

var console : DevConsole
	
func add_command(cmd: ConsoleCommand) -> void:
	if command_dict.has(cmd.name):
		print_debug("Command %s is already exists. Skipping" % cmd.name)
		return
	command_dict[cmd.name] = cmd

func run_command(raw_cmd : String) -> void:
	command_history.insert(0, raw_cmd)
	command_history_index = -1
	var command_split := raw_cmd.split(" ", false)
	if command_dict.has(command_split[0]):
		console.console_print_log(">%s\n" % raw_cmd)
		var output_string := await command_dict[command_split[0]].run_command(command_split.slice(1))
		console.console_print_log(output_string)
		
	else:
		console.console_print_log("Command '%s' is not found, try 'help'. Skipping\n" % raw_cmd)
