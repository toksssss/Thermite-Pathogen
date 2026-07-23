extends Node3D
class_name FloatingText

var label : Label3D

var text : String = ""

func _ready() -> void:
	label = %Label3D
	label.text = text
	
	position.x = randf_range(-0.5, 0.5)
	position.y = randf_range(2.0, 2.4)
	
	label.modulate.a = 0.5
	label.scale = Vector3(0.5, 0.5, 0.5)
	
	var tween : Tween = create_tween()
	
	tween.parallel().tween_property(label, "modulate:a", 1.0, 0.2)
	tween.parallel().tween_property(label, "scale", Vector3(2.0, 2.0, 2.0), 0.2)
	
	tween.tween_property(label, "modulate:a", 0.0, 0.5)
	tween.parallel().tween_property(label, "scale", Vector3(1.8, 1.8, 1.8), 0.2)
	
	tween.tween_callback(queue_free)

func _physics_process(delta: float) -> void:
	position.y += delta * 1.0

func set_text(_val: String) -> void:
	text = _val
	
