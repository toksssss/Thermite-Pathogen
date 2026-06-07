extends Node
class_name PreloadManager

signal resource_loading_complete

var use_sub_threads : bool = true
var resource_to_load : String

func _ready() -> void:
	set_process(false)

func load_scene_to_cache(path : String) -> PackedScene:
	resource_to_load = path
	var error := ResourceLoader.load_threaded_request(path, "", use_sub_threads)
	if !error:
		set_process(true)
		await resource_loading_complete
		return ResourceLoader.load_threaded_get(path)
	print_debug("Error accured while attempting to load scene to cache")
	return null

func _process(delta: float) -> void:
	var status := ResourceLoader.load_threaded_get_status(resource_to_load)
	match status:
		ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			resource_loading_complete.emit()
