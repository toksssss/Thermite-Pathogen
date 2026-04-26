extends Throwable
class_name Grenade

@export var particles : GPUParticles3D
@export var mesh_node : Node3D
@export var debug_mesh : MeshInstance3D
@export var hurtbox : Hurtbox

@export var damage : float = 30.0

func _ready() -> void:
	body_entered.connect(func(_x): explode())
	particles.finished.connect(func(): queue_free())
	
	create_attack_data()
	
	hurtbox.monitoring = false

func explode() -> void:
	hurtbox.monitoring = true
	
	particles.restart()
	debug_mesh.visible = true
	mesh_node.visible = false
	freeze = true

func create_attack_data() -> void:
	var attack_data := AttackData.new()
	attack_data.damage = damage
	hurtbox.attack_data = attack_data

func _enter_tree() -> void:
	apply_impulse(force)
