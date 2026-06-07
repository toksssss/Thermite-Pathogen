# Спиздил код у STS2 бу-га-га :P

extends Node3D
class_name RootSceneContainer

static var instance : RootSceneContainer:
	get:
		return GameManager.instance.scene_container


var current_scene: Node :
	get:
		if current_scene == null:
			return null
		if !is_instance_valid(current_scene):
			return null
		if current_scene.is_queued_for_deletion():
			return null
		return current_scene
	set(v):
		current_scene = v 

func set_current_scene(node: Node) -> void:
	for child: Node in get_children():
		child.queue_free.call_deferred()
	current_scene = node
	if node.get_parent() == null:
		add_child(node)
	else:
		node.reparent(self)
