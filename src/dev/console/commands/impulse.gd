extends ConsoleCommand
class_name ImpulseCommand

const WEAPON_RESOURCES : Dictionary[int, String] = {
	100 : "uid://lx7lgsgaxkp5", # default
	101 : "uid://cuq08t1huothi", # dev
}

func _init() -> void:
	name = "impulse"
	help_text = "Shortcut dev command. Use 'impulse <num>'"
	help_text_short = "Shortcuts"

func run_command(args: Array[String]) -> String:
	if len(args) == 0:
		return "No arguments. Skipping\n"

	match args[0]:
		'100':
			# default weapon
			var p : Player = GameManager.instance.get_tree().get_first_node_in_group("player")
			p.weapon.weapon_model.weapon_strategy = load(WEAPON_RESOURCES[100])
			return "Load default weapon strategy\n"
		'101':
			var p : Player = GameManager.instance.get_tree().get_first_node_in_group("player")
			p.weapon.weapon_model.weapon_strategy = load(WEAPON_RESOURCES[101])
			return "Load dev weapon strategy\n"
		_:
			return "Wrong argument. %s Failed\n" % args
