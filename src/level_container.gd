extends Node3D
class_name LevelContainer

signal level_changed

static var instance : LevelContainer:
	get:
		return GameplayManager.instance.level_container

var current_level: Node :
	get:
		if current_level == null:
			return null
		if !is_instance_valid(current_level):
			return null
		if current_level.is_queued_for_deletion():
			return null
		return current_level
	set(v):
		current_level = v 

func set_current_level(level: Node) -> void:
	for child: Node in get_children():
		child.queue_free.call_deferred()
	current_level = level
	if level.get_parent() == null:
		add_child(level)
	else:
		level.reparent(self)
	level_changed.emit()
