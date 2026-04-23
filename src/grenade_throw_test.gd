extends Node
class_name GrenadeTest

@export var player : Player
@onready var grenade_scene : PackedScene = preload("res://assets/throwable/throwable.tscn")

func throw_grenade(input: InputPackage) -> void:
	if !input.secondary_actions.has("throw"):
		return
	var grenade_instance : Throwable = grenade_scene.instantiate()
	player.get_tree().root.add_child(grenade_instance)
