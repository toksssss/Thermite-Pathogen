extends ConsoleCommand
class_name SetVolumeCommand

func _init() -> void:
	name = "set_volume"
	help_text = "Set master volume"
	help_text_short = "Set master volume"

func run_command(args: Array[String]) -> String:
	if len(args) == 0:
		var bus := FmodServer.get_bus_from_guid("{bcebe5cc-0091-40eb-b8e1-f8cab5a1df6c}")
		return "%s\n" % bus.get_volume()

	SfxCmd.set_master_volume(args[0] as float)
	UserSettings.volume = args[0] as float
	return "%s\n" % args[0]
