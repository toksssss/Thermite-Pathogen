@abstract
extends Node3D
class_name BaseLevel

var navigation_region : NavigationRegion3D
var terrain : Terrain3D

static func create() -> BaseLevel:
	return

func _ready() -> void:
	GameplayManager.instance.set_pause(false)
