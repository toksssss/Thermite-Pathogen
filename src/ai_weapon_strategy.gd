extends BaseWeaponStrategy
class_name AIWeaponStrategy

func attack(_source : Node, marker : Marker3D) -> void:
	var spawned_bullet : WeaponBullet = bullet_scene.instantiate()
	
	var attack_data : AttackData = AttackData.new()
	attack_data.damage = weapon_data.damage
	attack_data.source = self
	
	spawned_bullet.attack_data = attack_data
	
	spawned_bullet.speed = weapon_data.bullet_speed
	spawned_bullet.position = marker.global_position
	spawned_bullet.rotation = marker.global_rotation
	spawned_bullet.set_collision_layer_value(4, 1)
	spawned_bullet.set_collision_mask_value(1, 1)
	_source.get_tree().root.add_child(spawned_bullet)
	
	
