extends ConsoleCommand
class_name SetStageCommand

func _init() -> void:
	name = "set_stage"
	help_text = "Sets stage to current level using StageMachine"
	help_text_short = "Sets stage"

func run_command(args: Array[String]) -> String:
	if len(args) == 0:
		return "Provide at least 1 argument\n"
	if StageMachine.instance == null:
		return "No StageMachine was found. Skipped\n"
	if StageMachine.instance.states.has(args[0]):
		StageMachine.instance.force_new_state(args[0])
	else:
		return "%s stage was not found. Skipped\n" % args[0]
	return "Switch level stage to %s\n" % args[0]
