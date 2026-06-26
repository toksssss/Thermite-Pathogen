class_name ConsoleCommandsRegister

static func register_commands() -> void:
	DevConsoleManager.instance.add_command("help", HelpCommand.new())
