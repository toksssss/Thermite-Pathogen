extends Resource
class_name WeaponStrategy

@export var weapon_data : WeaponDataResource
@export var bullet_scene : PackedScene

signal kill_count_changed(count: int)

var kill_count : int : 
	set(v):
		kill_count = v
		kill_count_changed.emit(v)

var _current_bullets : int
var is_charged : bool

func attack(_source : WeaponModel) -> void:
	var spawned_bullet : WeaponBullet = bullet_scene.instantiate()
	
	var attack_data : AttackData = AttackData.new()
	attack_data.damage = weapon_data.damage
	attack_data.source = self
	
	spawned_bullet.attack_data = attack_data
	
	spawned_bullet.speed = weapon_data.bullet_speed
	spawned_bullet.position = _source.marker.global_position
	spawned_bullet.rotation = _source.marker.global_rotation
	_source.get_tree().root.add_child(spawned_bullet)


func pay_resource(state: WeaponState) -> void:
	lose_bullets(state.ammo_cost)

func reset_kill_count() -> void:
	kill_count = 0

func update_kill_count(count : int) -> void:
	kill_count = count

func lose_bullets(cost : int) -> void:
	if _current_bullets - cost >= 0:
		_current_bullets -= cost
	else:
		_current_bullets = 0

func reload() -> void:
	if _current_bullets < weapon_data.bullet_capacity:
		_current_bullets = weapon_data.bullet_capacity

func can_be_paid(state: WeaponState) -> bool:
	if _current_bullets - state.ammo_cost >= 0:
		return true
	return false
