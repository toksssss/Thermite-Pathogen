extends BaseAbilityBehavior
class_name SomeActiveAbilityBehavior

var white_box_scene : PackedScene = preload("res://assets/abilities/test_ability/spawn_test.tscn")

func apply_behavior(player: Player) -> void:
	var white_box : Node3D = white_box_scene.instantiate()
	player.add_child(white_box)
