extends Control
class_name SensitivitySpinBox

var spin : SpinBox

func _ready() -> void:
	spin = %SpinBox
	spin.value_changed.connect(change_sensitivity)
	spin.value = UserSettings.sensitivity

func change_sensitivity(_val: float) -> void:
	UserSettings.sensitivity = _val
	GameManager.instance.sensitivity_changed.emit()
