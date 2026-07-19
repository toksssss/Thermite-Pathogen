extends Node
class_name AudioProxy

var rig : Node3D
var event: FmodEvent

func _ready() -> void:
	rig = $".."

func play_sound_with_param_by_guid(guid: String, param: String = "", key: float = 0.0) -> void:
	if !FmodServer.check_event_guid(guid):
		print("No event was found with guid: " + guid)
		return
	if !event:
		event = FmodServer.create_event_instance_with_guid(guid)
	event.set_parameter_by_name(param, key)
	event.start()

func play_sound_with_params_by_guid(guid: String, params: Dictionary[String, float]) -> void:
	if !FmodServer.check_event_guid(guid):
		print("No event was found with guid: " + guid)
		return
	if !event:
		event = FmodServer.create_event_instance_with_guid(guid)
	for key: String in params.keys():
		event.set_parameter_by_name(key, params[key])
	event.start()

func play_one_shot_using_guid_attached(guid: String) -> void:
	if !FmodServer.check_event_guid(guid):
		print("No event was found with guid: " + guid)
		return
	FmodServer.play_one_shot_using_guid_attached(guid, rig)
