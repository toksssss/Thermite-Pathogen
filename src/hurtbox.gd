extends Area3D
class_name Hurtbox

var attack_data : AttackData

signal hit_enemy

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(area: Area3D) -> void:
	if area is Hitbox:
		var hitbox : Hitbox = area as Hitbox
		if attack_data.ignore_list.has(hitbox.parent):
			return

		attack_data.ignore_list.append(hitbox.parent)
		
		hitbox.damage(attack_data)
		hit_enemy.emit()
