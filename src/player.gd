extends CharacterBody3D
class_name Player

@export var input_gatherer : InputGatherer
@export var model : PlayerModel
@export var weapon : PlayerWeapon
@export var head : Node3D

func _physics_process(delta: float) -> void:
	var input : InputPackage = input_gatherer.gather_input()
	model.update(input, delta)
	weapon.update(input, delta)
	
	#print(velocity)
