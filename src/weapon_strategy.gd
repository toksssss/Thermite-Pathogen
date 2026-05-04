extends Resource
class_name WeaponStrategy

@export var weapon_resource : WeaponResource
@export var bullet_scene : PackedScene

func attack(_source : WeaponModel) -> void:
	var spawned_bullet : WeaponBullet = bullet_scene.instantiate()
	
	var attack_data : AttackData = AttackData.new()
	attack_data.damage = weapon_resource.damage
	spawned_bullet.attack_data = attack_data
	
	spawned_bullet.speed = weapon_resource.bullet_speed
	spawned_bullet.position = _source.marker.global_position
	spawned_bullet.rotation = _source.marker.global_rotation
	_source.get_tree().root.add_child(spawned_bullet)
