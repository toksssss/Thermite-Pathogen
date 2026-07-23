extends Node3D
class_name PlayerWeapon

@export var weapon_model : WeaponModel
@export var weapon_sway : WeaponSway

func physics_update(input: InputPackage, delta: float) -> void:
	weapon_model.update(input, delta)

func update(input: InputPackage, delta: float) -> void:
	weapon_sway.sway(weapon_model.weapon_strategy, input, delta)
