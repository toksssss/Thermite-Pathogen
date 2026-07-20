extends Node
class_name AudioManager

static var instance : AudioManager:
	get:
		return GameManager.instance.audio_manager

var master_bus : FmodBus
var sfx_bus : FmodBus
var music_bus : FmodBus

var loops: Dictionary[String, FmodEvent]

func play_loop(_guid: String, _volume := 1.0) -> void:
	if !FmodServer.check_event_guid(_guid):
		print("No event was found with guid: " + _guid)
		return
	
	var event := FmodServer.create_event_instance_with_guid(_guid)
	#if !loops.has(_guid):
		#loops[_guid] = []
	
	loops[_guid] = event
	event.set_volume(_volume)
	event.start()
	event.release()

func stop_loop(_guid: String) -> void:
	if loops.has(_guid):
		var event : FmodEvent = loops[_guid]
		event.stop(0)

func set_param(_guid: String, _param: String, _val: float) -> void:
	if loops.has(_guid):
		var event : FmodEvent = loops[_guid]
		event.set_parameter_by_name(_param, _val)
		event.start()

func play_sfx_by_guid(sfx_guid: String) -> void:
	if !FmodServer.check_event_guid(sfx_guid):
		print("No sound was found with guid: " + sfx_guid)
		return
	FmodServer.play_one_shot_using_guid(sfx_guid)

func play_one_shot(guid: String, params: Dictionary = {}, volume: float = 1.0) -> void:
	if !FmodServer.check_event_guid(guid):
		print("No event was found with guid: " + guid)
		return
	
	var event_desc : FmodEventDescription = FmodServer.get_event_from_guid(guid)
	var valid_params : Array[String] = []
	if event_desc:
		for p: FmodParameterDescription in event_desc.get_parameters():
			valid_params.append(p.get_name())
	
	var event : FmodEvent = FmodServer.create_event_instance_with_guid(guid)
	
	for key: String in params:
		if key in valid_params:
			event.set_parameter_by_name(key, params[key])
		else:
			print("Warning! Fmod Parameter %s was not found on event guid %s" % [key, guid])
	
	event.set_volume(volume)
	event.start()
	event.release()

func play_one_shot_at_position(guid: String, position: Transform3D, params: Dictionary = {}, volume: float = 1.0) -> void:
	if !FmodServer.check_event_guid(guid):
		print("No event was found with guid: " + guid)
		return
	
	var event_desc : FmodEventDescription = FmodServer.get_event_from_guid(guid)
	var valid_params : Array[String] = []
	if event_desc:
		for p: FmodParameterDescription in event_desc.get_parameters():
			valid_params.append(p.get_name())
	
	var event : FmodEvent = FmodServer.create_event_instance_with_guid(guid)
	
	for key: String in params:
		if key in valid_params:
			@warning_ignore("unsafe_call_argument")
			event.set_parameter_by_name(key, params[key])
		else:
			print("Warning! Fmod Parameter %s was not found on event guid %s" % [key, guid])
	
	event.set_volume(volume)
	event.set_3d_attributes(position)
	event.start()
	event.release()

func play_one_shot_attached(guid: String, node: Node, params: Dictionary = {}, volume: float = 1.0) -> void:
	if !FmodServer.check_event_guid(guid):
		print("No event was found with guid: " + guid)
		return
	
	var event_desc : FmodEventDescription = FmodServer.get_event_from_guid(guid)
	var valid_params : Array[String] = []
	if event_desc:
		for p: FmodParameterDescription in event_desc.get_parameters():
			valid_params.append(p.get_name())
	
	var event : FmodEvent = FmodServer.create_event_instance_with_guid(guid)
	
	for key: String in params:
		if key in valid_params:
			event.set_parameter_by_name(key, params[key])
		else:
			print("Warning! Fmod Parameter %s was not found on event guid %s" % [key, guid])
	
	event.set_volume(volume)
	event.set_node_attributes(node)
	event.start()
	event.release()

func play_one_shot_attached_(_guid: String, node: Node3D) -> void:
	if !FmodServer.check_event_guid(_guid):
		print("No event was found with guid: " + _guid)
		return
	
	FmodServer.play_one_shot_using_guid_attached(_guid, node)

func set_master_volume(volume: float) -> void:
	if master_bus == null:
		master_bus = FmodServer.get_bus_from_guid("{bcebe5cc-0091-40eb-b8e1-f8cab5a1df6c}")
	if master_bus != null:
		master_bus.set_volume(volume)

func set_sfx_volume(volume: float) -> void:
	if sfx_bus == null:
		sfx_bus = FmodServer.get_bus_from_guid("{6c83b5b6-b92e-4e6f-b438-9ce8034195fa}")
	if sfx_bus != null:
		sfx_bus.set_volume(volume)

func set_music_volume(volume: float) -> void:
	if music_bus == null:
		music_bus = FmodServer.get_bus_from_guid("")
	if music_bus != null:
		music_bus.set_volume(volume)
