extends LevelStage

@warning_ignore("unused_parameter")
func physics_update(delta: float) -> void:
	if LevelTimer.instance.current_level_min >= threshold_min:
		transitioned.emit(self, "none")

	if !is_cooldown:
		for enemie: PackedScene in enemie_scenes:
			SpawningManager.instance.spawn_mob(enemie.instantiate() as Node3D)
		timer.start(spawning_rate)
		is_cooldown = true
