extends CharacterBody3D
class_name Player

@export var input_gatherer : InputGatherer
@export var model : PlayerModel
@export var weapon : PlayerWeapon
@export var head : PlayerHead
@export var stand_collision : CollisionShape3D
@export var crouch_collision : CollisionShape3D
@export var abilities_manager : PlayerAbilitiesManager
@export var velocity_component : VelocityComponent
@export var head_movement_component : HeadMovementComponent

# flags
var is_crouching : bool = false

func _physics_process(delta: float) -> void:
	var input : InputPackage = input_gatherer.gather_input()
	model.update(input, delta)
	weapon.physics_update(input, delta)
	abilities_manager.try_to_use_ability(input)
	velocity_component.move_and_slide()

func _process(delta: float) -> void:
	var input : InputPackage = input_gatherer.gather_movement()
	weapon.update(input, delta)

func _exit_tree() -> void:
	remove_from_group("player")
