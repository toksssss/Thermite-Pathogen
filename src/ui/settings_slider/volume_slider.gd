extends Control
class_name VolumeSlider

var slider : HSlider

func _ready() -> void:
	slider = %HSlider
	slider.drag_ended.connect(set_volume)
	slider.value = UserSettings.volume
	AudioManager.instance.master_volume_changed.connect(func() -> void: slider.value = UserSettings.volume)
	set_volume(true)

func set_volume(flag: bool = true) -> void:
	if flag:
		UserSettings.volume = slider.value
		SfxCmd.set_master_volume(slider.value)
