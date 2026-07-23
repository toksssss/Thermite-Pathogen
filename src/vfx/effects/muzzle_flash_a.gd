@tool
extends Vfx

var light : OmniLight3D

func _ready() -> void:
	light = %OmniLight3D

func play_vfx() -> void:
	super.play_vfx()
	var tween : Tween = create_tween()
	tween.tween_property(light, "light_energy", 1, 0.03)
	tween.tween_property(light, "light_energy", 0, 0.16)
