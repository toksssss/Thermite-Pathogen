extends Node
class_name WeaponResourcesStore

@export var max_bullets : int
var _current_bullets : int

func _ready() -> void:
	_current_bullets = max_bullets

func pay_resource(state: WeaponState) -> void:
	lose_bullets(state.ammo_cost)

func lose_bullets(cost : int) -> void:
	if _current_bullets - cost >= 0:
		_current_bullets -= cost
	else:
		_current_bullets = 0

func reload() -> void:
	if _current_bullets < max_bullets:
		_current_bullets = max_bullets

func can_be_paid(state: WeaponState) -> bool:
	if _current_bullets - state.ammo_cost >= 0:
		return true
	return false
