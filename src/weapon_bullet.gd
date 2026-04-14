extends Node3D
class_name WeaponBullet

@export var hurtbox : Hurtbox

var attack_data : AttackData

var speed : float = 10.0
var spawn_pos : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_pos = position
	hurtbox.hit_enemy.connect(on_hit, CONNECT_DEFERRED)

func _physics_process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, speed) * delta
	
	if spawn_pos.distance_to(position) > 100:
		queue_free()

func on_hit() -> void:
	queue_free()
