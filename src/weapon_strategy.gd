extends Resource
class_name WeaponStrategy

@export var weapon_data : WeaponDataResource
@export var bullet_scene : PackedScene

# Добавить сюда attack behavior и charged attack behavior
# И делать через: 
# func primary_action(): attack_behavior.apply_behavior()
# func secondary_action(): charged_behavior.apply_behavior() 

#signal kill_count_changed(count: int)
signal weapon_charged

var kill_count : int : 
	set(v):
		kill_count = v
		on_kill_count_changed()

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

func charged_attack(_source : WeaponModel) -> void:
	var spawned_bullet : WeaponBullet = bullet_scene.instantiate()
	
	var attack_data : AttackData = AttackData.new()
	attack_data.damage = weapon_data.damage * 2
	attack_data.source = self
	
	spawned_bullet.attack_data = attack_data
	
	spawned_bullet.speed = weapon_data.bullet_speed
	spawned_bullet.position = _source.marker.global_position
	spawned_bullet.rotation = _source.marker.global_rotation
	_source.get_tree().root.add_child(spawned_bullet)

func pay_resource(state: WeaponState) -> void:
	lose_bullets(state.ammo_cost)
	lose_kill_count(state.kill_cost)

func reset_kill_count() -> void:
	kill_count = 0

func update_kill_count(count : int) -> void:
	kill_count = count

func on_kill_count_changed() -> void:
	# Пока хардкодим бля
	if kill_count >= 3:
		is_charged = true
		weapon_charged.emit()

func lose_bullets(cost : int) -> void:
	if _current_bullets - cost >= 0:
		_current_bullets -= cost
	else:
		_current_bullets = 0

func lose_kill_count(cost: int) -> void:
	if kill_count - cost >= 0:
		kill_count -= cost
	else:
		kill_count = 0

func reload() -> void:
	if _current_bullets < weapon_data.bullet_capacity:
		_current_bullets = weapon_data.bullet_capacity

func can_be_paid(state: WeaponState) -> bool:
	if _current_bullets - state.ammo_cost >= 0:
		if kill_count - state.kill_cost >= 0:
			return true
	return false
