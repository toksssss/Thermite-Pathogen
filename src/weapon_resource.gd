extends Resource
class_name WeaponResource

@export var name : String
@export var damage : float
@export var speed : float
@export var weapon_scene : PackedScene

@export_category("Transform")
@export var position : Vector3
@export var rotation : Vector3
@export var scale : Vector3

@export var input_to_state : Dictionary[String, String]

# animations, icons, model, speed, penetration, sound etc.
