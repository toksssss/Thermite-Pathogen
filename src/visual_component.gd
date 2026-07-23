extends Node
class_name VisualComponent

@export var visuals : Array[MeshInstance3D]

var tween : Tween
var text_scene : PackedScene
var def_emissions : Array[Color]

func _ready() -> void:
	text_scene = await PreloadManager.instance.load_scene_to_cache("uid://481x4tcxgork")
	for v: MeshInstance3D in visuals:
		var m : StandardMaterial3D = v.get_active_material(0) 
		def_emissions.append(m.emission)

func damage(_data: AttackData) -> void:
	change_color()
	spawn_text(_data.damage)

func change_color() -> void:
	if tween != null:
		tween.kill()

	tween = get_tree().create_tween()
	var i := 0
	for v : MeshInstance3D in visuals:
		var m : StandardMaterial3D = v.get_active_material(0)
		var e : float = m.emission_energy_multiplier
		
		m.emission_energy_multiplier = 1.0
		m.emission = Color(1.0 , 1.0, 1.0)
		
		tween.parallel().tween_property(m, "emission", def_emissions[i], 0.3)
		tween.parallel().tween_property(m, "emission_energy_multiplier", e, 0.3)
		i += 1

func spawn_text(_val: float) -> void:
	var text : FloatingText = text_scene.instantiate()
	text.set_text("%s" % _val)
	Utils.add_child_safe(text, owner)
