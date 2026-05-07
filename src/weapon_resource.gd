extends Resource
class_name WeaponDataResource

@export var name : String
@export var weapon_scene : PackedScene

@export_group("Stats")
@export var damage : float
@export var bullet_capacity : int
@export var bullet_speed : float

@export_group("Transform")
@export var position : Vector3
@export var rotation : Vector3 = Vector3(0.0, 0.0, 0.0)
@export var scale : Vector3 = Vector3(1.0, 1.0, 1.0)

@export_group("Weapon Sway")
@export var sway_min : Vector2 = Vector2(-20, -20)
@export var sway_max : Vector2 = Vector2(20, 20)
@export var sway_speed_position : float = 0.07
@export var sway_speed_rotation : float = 0.1
@export var sway_amount_position : float = 0.1
@export var sway_amount_rotation : float = 30

@export_group("TBD")
@export var input_to_state : Dictionary[String, String]



# animations, icons, model, speed, penetration, sound etc.
