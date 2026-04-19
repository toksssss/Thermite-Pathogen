class_name BulletDecalPool

# TODO: В настройках можно поменять
const MAX_BULLET_DECALS = 5
static var decal_pool : Array[PackedScene] = []

static var decal_scene : PackedScene = preload("res://assets/decals/bullet_hole/bullet_hole.tscn")

static func spawn_bullet_decal(global_pos : Vector3, normal: Vector3, 
parent: Node3D, bullet_basis : Basis, texture_override = null) -> void:
	var decal_instance : Decal
	if decal_pool.size() >= MAX_BULLET_DECALS and is_instance_valid(decal_pool[0]):
		decal_instance = decal_pool.pop_front()
		decal_pool.push_back(decal_instance)
		decal_instance.reparent(parent)
	else:
		decal_instance = decal_scene.instantiate()
		parent.add_child(decal_instance)
		decal_pool.push_back(decal_instance)
	
	if !is_instance_valid(decal_pool[0]):
		decal_pool.pop_front()
	
	# Rotate decal towards player
	decal_instance.global_transform = (Transform3D(bullet_basis, global_pos) * 
	Transform3D(Basis().rotated(Vector3(1, 0, 0), deg_to_rad(90)), Vector3()))
	
	# Align to surface
	decal_instance.global_basis = (Basis(Quaternion(decal_instance.global_basis.y, normal)) 
	* decal_instance.global_basis)
	
	(decal_instance.get_node("GPUParticles3D") as GPUParticles3D).emitting = true
	
	if texture_override is Texture2D:
		decal_instance.texture_albedo = texture_override
