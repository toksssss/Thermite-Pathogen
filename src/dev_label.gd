extends Label

@export var model : PlayerModel
@export var weapon : WeaponModel
@export var player : Player
@export var sway : WeaponSway

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	text = ""
	text += "Velocity:%10.3f\n" % player.velocity.length()
	text += "PlayerMove: %s\n" % model.current_move.name
	text += "WeaponState: %s\n" % weapon.current_state.name
	text += "StandCollisionShape is enabled: %s\n" % !player.stand_collision.disabled
	text += "CrouchCollisionShape is enabled: %s\n" % !player.crouch_collision.disabled
	text += "HeadRayCast is colliding: %s\n" % model.head_checker.is_colliding()
	text += "Sway MouseMovement: %s\n" % sway.mouse_movement
