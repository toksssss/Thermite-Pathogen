extends ConsoleCommand
class_name GetNodesInGroupCommand

func _init() -> void:
	name = "get_nodes_in_group"
	help_text = "Prints nodes names that are in group. Use like 'get_nodes_in_group <group_name>'"
	help_text_short = "Prints nodes names that are in group"

func run_command(args: Array[String]) -> String:
	if len(args) == 0:
		return "Provide at least 1 argument\n"
	var group_name : String = args[0]
	if GameManager.instance.get_tree().has_group(group_name):
		var counter : int = 0
		var return_string := ""
		for node: Node in GameManager.instance.get_tree().get_nodes_in_group(group_name):
			return_string += "%s - %d" % [node.name, node.get_instance_id()]
			counter += 1
		return_string += "\n%d nodes was found\n" % counter
		return return_string
	return "%s group was not found. Failed\n" % group_name
