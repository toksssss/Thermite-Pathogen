extends Node
class_name AudioManager

static var instance : AudioManager:
	get:
		return GameManager.instance.audio_manager

func play_sound(sfx: String, args: Dictionary[String, Variant] = {}) -> void:
	pass

func play_sfx_by_guid(sfx_guid: String) -> void:
	if !FmodServer.check_event_guid(sfx_guid):
		print("No sound was found with guid: " + sfx_guid)
		return
	FmodServer.play_one_shot_using_guid(sfx_guid)
