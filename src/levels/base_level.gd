@abstract
extends Node3D
class_name BaseLevel

var navigation_region : NavigationRegion3D

static func create() -> BaseLevel:
	return

func _ready() -> void:
	navigation_region = %NavigationRegion3D
