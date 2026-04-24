extends Throwable
class_name Grenade

@export var particles : GPUParticles3D
@export var mesh : MeshInstance3D
@export var debug_mesh : MeshInstance3D
@export var hurtbox : Hurtbox

var damage : float

func _ready() -> void:
	super._ready()
	hurtbox.monitoring = false
	
	var attack_data := AttackData.new()
	damage = 30
	attack_data.damage = damage
	hurtbox.attack_data = attack_data

func _on_timer_timeout() -> void:
	particles.restart()
	particles.finished.connect(_on_partice_finished, CONNECT_DEFERRED)
	hurtbox.monitoring = true
	debug_mesh.visible = true
	mesh.visible = false

func _on_partice_finished() -> void:
	queue_free()
