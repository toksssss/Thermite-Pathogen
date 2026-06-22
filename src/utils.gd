class_name Utils

static func add_child_safe(node: Node, parent: Node) -> void:
	if node.is_queued_for_deletion():
		print_debug("Node is queued for deletion")
		return
	if node.is_inside_tree():
		node.reparent(parent)
	else:
		parent.add_child(node)
