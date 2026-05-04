extends EnemiesState

func enter() -> void:
	_randomize_wander()

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if !npc:
		return
	
	#var distance := player.global_position - npc.global_position
	#if distance.length() <= 20:
		#transitioned.emit(self, "follow")
	
	if navigation_agent.is_navigation_finished():
		npc.velocity = Vector3.ZERO
		_randomize_wander()
	
	var destination := navigation_agent.get_next_path_position()
	var local_destination := destination - npc.global_position
	var direction := local_destination.normalized()
	navigation_agent.velocity = direction * 5.0

func _randomize_wander() -> void:
	var random_direction := Vector3(randf_range(-10, 10), npc.position.y, randf_range(-10,10))
	navigation_agent.set_target_position(npc.global_position - random_direction)
