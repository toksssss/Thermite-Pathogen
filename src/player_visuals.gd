extends Node3D

@export var mesh : MeshInstance3D

func accept_skeleton(skeleton: Skeleton3D) -> void:
	mesh.skeleton = skeleton.get_path()
