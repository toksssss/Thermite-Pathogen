class_name Sfx

static func play_sfx(sound_guid: String) -> void:
	AudioManager.instance.play_sfx_by_guid(sound_guid)
