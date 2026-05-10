extends Node
class_name VelocityComponent

var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var player : Player = $"../.."

@export var acceleration : float = 12
@export var deacceleration : float = 18

var velocity : Vector3

func move_and_slide() -> void:
	player.velocity = velocity
	player.move_and_slide()
	# Костыль, но если этого не делать, 
	# то velocity не реагирует на коллизию, трение и т.д
	velocity = player.velocity

func accelerate_to(new_vel: Vector3, direction: Vector3, delta: float) -> void:
	if direction.dot(new_vel) > 0:
		velocity.x = lerp(velocity.x, new_vel.x, delta * acceleration)
		velocity.z = lerp(velocity.z, new_vel.z, delta * acceleration)
	else:
		velocity.x = lerp(velocity.x, new_vel.x, delta * deacceleration)
		velocity.z = lerp(velocity.z, new_vel.z, delta * deacceleration)

func accelerate_to_zero(delta: float) -> void:
	velocity.x = lerp(velocity.x, 0.0, delta * deacceleration)
	velocity.z = lerp(velocity.z, 0.0, delta * deacceleration)

func apply_gravity(delta: float) -> void:
	velocity.y -= gravity * delta

func jump(force: float) -> void:
	velocity.y += force
