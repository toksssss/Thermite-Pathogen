extends Node

@onready var player : Player = $"../.."

@export var stand_head_height : float = 0.7
@export var crouch_head_height : float = 0.3
var lerp_time : float = 12


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var temp_head_height : float = player.head.position.y
	if player.is_crouching:
		temp_head_height = lerp(temp_head_height, crouch_head_height, delta * lerp_time)
	else:
		temp_head_height = lerp(temp_head_height, stand_head_height, delta * lerp_time)
	player.head.position.y = temp_head_height
		
		
		
