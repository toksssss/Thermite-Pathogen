extends Throwable
class_name Grenade

@export var particles : GPUParticles3D
@export var mesh_node : Node3D
@export var debug_mesh : MeshInstance3D
@export var hurtbox : Hurtbox

@export var damage : float = 30.0

func _ready() -> void:
	body_entered.connect(_on_body_entered, CONNECT_ONE_SHOT)
	particles.finished.connect(_on_partice_finished, CONNECT_ONE_SHOT)
	
	hurtbox.monitoring = false

func _on_body_entered(_body: Node) -> void:
	explode()

func explode() -> void:
	particles.restart()
	hurtbox.monitoring = true
	debug_mesh.visible = true
	mesh_node.visible = false

func create_attack_data() -> void:
	var attack_data := AttackData.new()
	attack_data.damage = damage
	hurtbox.attack_data = attack_data

func _on_partice_finished() -> void:
	queue_free()

func _enter_tree() -> void:
	apply_impulse(force)
