extends BaseMovementStrategy
class_name SpeedMovementStrategy

func apply_upgrade(model : PlayerModel) -> void:
	model.walk_speed *= 2.0
