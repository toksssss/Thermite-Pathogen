extends CharacterBody3D
class_name Player

@export var input_gatherer : InputGatherer
@export var model : PlayerModel

func _physics_process(delta: float) -> void:
	var input : InputPackage = input_gatherer.gather_input()
	model.update(input, delta)
	
	print(velocity)
