extends BaseWeaponStrategy
class_name AIWeaponStrategy

const TIME := 0.27

func attack(_source : Node, marker : Marker3D) -> void:
	var spawned_bullet : WeaponBullet = bullet_scene.instantiate()
	
	var attack_data : AttackData = AttackData.new()
	attack_data.damage = weapon_data.damage
	attack_data.source = self
	
	spawned_bullet.attack_data = attack_data
	
	spawned_bullet.speed = weapon_data.bullet_speed
	spawned_bullet.position = marker.global_position
	spawned_bullet.rotation = marker.global_rotation
	spawned_bullet.hurtbox.set_collision_layer_value(4, 1)
	spawned_bullet.hurtbox.set_collision_mask_value(1, 1)
	
	# TODO: Переделать
	var player : Player = _source.get_tree().get_first_node_in_group("player")
	var position := calculate_final_pos(player.global_position, player.velocity, player.model.acceleration)
	position.y -= 0.3
	spawned_bullet.look_at_from_position(spawned_bullet.position, position)
	
	# TODO: Переделать
	_source.get_tree().root.add_child(spawned_bullet)
	
func calculate_final_pos(pos: Vector3, vel: Vector3, accel: float) -> Vector3:
	var result : Vector3 = Vector3.ZERO
	
	result.x = pos.x + (vel.x * TIME) + (0.5 * accel * TIME * TIME)
	result.y = pos.y + (vel.y * TIME) + (0.5 * accel * TIME * TIME)
	result.z = pos.z + (vel.z * TIME) + (0.5 * accel * TIME * TIME)
	
	return result
