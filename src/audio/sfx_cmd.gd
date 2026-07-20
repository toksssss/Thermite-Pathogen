class_name SfxCmd

static func play_sfx_by_guid(sfx_guid: String) -> void:
	AudioManager.instance.play_sfx_by_guid(sfx_guid)

static func play_one_shot(guid: String, params: Dictionary[String, float] = {}, volume: float = 1.0) -> void:
	AudioManager.instance.play_one_shot(guid, params, volume)

static func play_one_shot_at_position(guid: String, position: Transform3D, params: Dictionary[String, float] = {}, volume: float = 1.0) -> void:
	AudioManager.instance.play_one_shot_at_position(guid, position, params, volume)

static func play_one_shot_attached(guid: String, node: Node, params: Dictionary[String, float] = {}, volume: float = 1.0) -> void:
	AudioManager.instance.play_one_shot_attached(guid, node, params, volume)

static func play_one_shot_attached_(guid: String, node: Node3D) -> void:
	AudioManager.instance.play_one_shot_attached_(guid, node)

static func play_one_shot_attached_with_params(guid: String, node: Node3D, params: Dictionary) -> void:
	AudioManager.instance.play_one_shot_attached_with_params(guid, node, params)

static func play_loop(_guid: String) -> void:
	AudioManager.instance.play_loop(_guid)

static func stop_loop(_guid: String) -> void:
	AudioManager.instance.stop_loop(_guid)

static func set_master_volume(volume: float) -> void:
	AudioManager.instance.set_master_volume(volume)

static func set_sfx_volume(volume: float) -> void:
	AudioManager.instance.set_sfx_volume(volume)

static func set_music_volume(volume: float) -> void:
	AudioManager.instance.set_music_volume(volume)
