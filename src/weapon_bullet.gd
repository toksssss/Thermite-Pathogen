extends CharacterBody3D
class_name WeaponBullet

@export var hurtbox : Hurtbox

var attack_data : AttackData

var speed : float = 10.0
var spawn_pos : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_pos = position
	hurtbox.hit_enemy.connect(on_hit, CONNECT_DEFERRED)
	hurtbox.attack_data = attack_data

func _physics_process(delta: float) -> void:
	velocity = transform.basis * Vector3(0, 0, speed)
	
	var collision : KinematicCollision3D = move_and_collide(velocity*delta)
	
	if collision:
		var obj : Object = collision.get_collider()
		var nrml : Vector3 = collision.get_normal()
		var pt : Vector3 = collision.get_position()
		var material : Material
		if obj is StaticBody3D:
			var mesh : MeshInstance3D = obj.get_node("MeshInstance3D")
			material = mesh.material_override
		BulletDecalPool.spawn_bullet_decal(pt, nrml, obj, global_basis, material)
		
	
	if spawn_pos.distance_to(position) > 100:
		queue_free()

func on_hit() -> void:
	queue_free()
