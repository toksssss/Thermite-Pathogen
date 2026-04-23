extends Node3D
class_name PlayerWeapon

@export var weapon_model : WeaponModel
@export var weapon_sway : WeaponSway
@export var grenade : GrenadeTest

func update(input: InputPackage, delta: float) -> void:
	weapon_model.update(input, delta)
	weapon_sway.sway(weapon_model.current_weapon_strategy, input, delta)
