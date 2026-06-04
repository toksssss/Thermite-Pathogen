@abstract
extends Resource
class_name BaseWeaponStrategy

@export var weapon_data : WeaponDataResource
@export var bullet_scene : PackedScene

func attack(_source : Node, marker : Marker3D) -> void:
	pass

func alternative_attack(_source : Node, marker : Marker3D) -> void:
	pass
