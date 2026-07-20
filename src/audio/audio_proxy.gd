extends Node
class_name AudioProxy

var node : Node3D

func _ready() -> void:
	node = $".."

func play_one_shot(_guid: String, _params: Dictionary = {}, _volume: float = 1.0) -> void:
	AudioManager.instance.play_one_shot(_guid, _params, _volume)

func play_one_shot_attached(_guid: String, _params: Dictionary = {}, _volume: float = 1.0) -> void:
	AudioManager.instance.play_one_shot_attached(_guid, node, _params, _volume)

func play_one_shot_attached_(_guid: String) -> void:
	AudioManager.instance.play_one_shot_attached_(_guid, node)

func play_loop(_guid: String) -> void:
	AudioManager.instance.play_loop(_guid)

func stop_loop(_guid: String) -> void:
	AudioManager.instance.stop_loop(_guid)

func set_param(_guid: String, _param: String, _val: float) -> void:
	AudioManager.instance.set_param(_guid, _param, _val)
