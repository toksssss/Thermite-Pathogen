@tool
extends Node3D
class_name Vfx

@export_tool_button("Preview Effect", "Callable") var play_action : Callable = _play_vfx_engine

@export_category("Particles")
@export var particles : Array[GPUParticles3D]
#@export var size_scale : float = 1.0

#var s_scale : float = 1.0
 
func _play_vfx_engine() -> void:
	for p : GPUParticles3D in particles:
		#var init_size = p.draw_pass_1.size
		#p.draw_pass_1.size *= size_scale
		p.restart()
		#p.draw_pass_1.size = init_size


func play_vfx() -> void:
	for p : GPUParticles3D in particles:
		#var init_size = p.draw_pass_1.size
		#p.draw_pass_1.size *= s_scale
		p.restart()
		#p.draw_pass_1.size = init_size
