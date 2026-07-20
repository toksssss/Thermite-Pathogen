class_name ConsoleCommandsRegister

static func register_commands() -> void:
	DevConsoleManager.instance.add_command(HelpCommand.new())
	DevConsoleManager.instance.add_command(QuitCommand.new())
	DevConsoleManager.instance.add_command(TrollfaceCommand.new())
	DevConsoleManager.instance.add_command(ClearCommand.new())
	DevConsoleManager.instance.add_command(ChangelevelCommand.new())
	DevConsoleManager.instance.add_command(GetNodesInGroupCommand.new())
	DevConsoleManager.instance.add_command(SetStageCommand.new())
	DevConsoleManager.instance.add_command(ImpulseCommand.new())
	DevConsoleManager.instance.add_command(SetVolumeCommand.new())
