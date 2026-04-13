extends Marker3D

@export var player : Player

@export_category("Settings")
@export var sensetivity : float = 2.0

var actual_rotation : Vector3 = Vector3.ZERO

func _ready() -> void:
	actual_rotation.y = player.rotation.y
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_head(event.screen_relative)

func rotate_head(mouse_axis: Vector2) -> void:
	# Horizontal look
	actual_rotation.y -= mouse_axis.x * (sensetivity / 1000)
	# Vertical look
	actual_rotation.x = clamp(actual_rotation.x - mouse_axis.y * (sensetivity / 1000), -90, 90)
	
	player.rotation.y = actual_rotation.y
	rotation.x = actual_rotation.x
