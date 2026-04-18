extends CharacterBody3D
class_name Player

@export var input_gatherer : InputGatherer
@export var model : PlayerModel
@export var weapon : PlayerWeapon
@export var head : Marker3D
@export var collision : CollisionShape3D

# flags
var is_crouching : bool = false

func _physics_process(delta: float) -> void:
	var input : InputPackage = input_gatherer.gather_input()
	model.update(input, delta)
	weapon.update(input, delta)
	
	#print("%10.3f" % velocity.length())
