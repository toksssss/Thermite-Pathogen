extends BaseAbilityBehavior
class_name ThrowAbilityBehavior

@export var item_scene : PackedScene
@export var throw_power : float = 1.0

func apply_behavior(player: Player) -> void:
	var direction : Vector3 = (player.head.marker.global_basis * Vector3(0, 0, 1)).normalized()
	var force : Vector3 = direction * throw_power + player.velocity / 5.0 
	
	var item : Throwable = item_scene.instantiate()
	item.force = force
	item.position = player.head.marker.global_position
	player.get_tree().root.add_child(item)
	
	
	
