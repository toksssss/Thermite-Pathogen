extends Node3D
class_name PlayerWeapon

@export var weapon_model : WeaponModel
@export var visuals : WeaponVisuals

func update(input: InputPackage, delta: float) -> void:
	weapon_model.update(input, delta)
