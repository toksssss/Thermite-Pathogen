extends Marker3D
class_name PlayerHead

@export var player : Player
@export var marker : Marker3D
@onready var camera : Camera3D = $Pivot/Camera3D
@export var pivot : Node3D

@export_category("Settings")
@export var sensetivity : float = 2.0

@onready var angle_limit : float = deg_to_rad(90)

var actual_rotation : Vector3 = Vector3.ZERO

func _ready() -> void:
	pivot.top_level = true
	pivot.physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_OFF
	
	actual_rotation.y = player.rotation.y

func _process(delta: float) -> void:
	pivot.transform = get_global_transform_interpolated()
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_head((event as InputEventMouseMotion).screen_relative)

func rotate_head(mouse_axis: Vector2) -> void:
	# Horizontal look
	actual_rotation.y -= mouse_axis.x * (sensetivity / 1000)
	# Vertical look
	actual_rotation.x = clamp(actual_rotation.x - mouse_axis.y * (sensetivity / 1000), -angle_limit, angle_limit)
	
	player.rotation.y = actual_rotation.y
	rotation.x = actual_rotation.x
