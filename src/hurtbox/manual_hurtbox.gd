extends Hurtbox
class_name ManualHurtbox

func damage() -> void:
	for body: Area3D in get_overlapping_areas():
		if body is Hitbox:
			(body as Hitbox).damage(attack_data)
