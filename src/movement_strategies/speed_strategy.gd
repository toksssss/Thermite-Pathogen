extends BaseMovementStrategy
class_name SpeedMovementStrategy

func apply_upgrade(model : PlayerModel) -> void:
	model.base_speed *= 2.0
