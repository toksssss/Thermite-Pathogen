extends Label

@export var model : PlayerModel
@export var weapon : WeaponModel
@export var player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	text = ""
	text += "Velocity:%10.3f\n" % player.velocity.length()
	text += "PlayerMove: %s\n" % model.current_move.name
	text += "WeaponState: %s\n" % weapon.current_state.name
