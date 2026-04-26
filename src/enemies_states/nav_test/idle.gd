extends EnemiesState

var wander_time : float

func enter() -> void:
	_randomize_wander()

func exit() -> void:
	pass

func update(delta: float) -> void:
	if wander_time > 0:
		wander_time -= delta
	else:
		_randomize_wander()

func physics_update(_delta: float) -> void:
	if !npc:
		return
	
	if navigation_agent.is_navigation_finished():
		npc.velocity = Vector3.ZERO
		return
	
	var destination := navigation_agent.get_next_path_position()
	var local_destination := destination - npc.global_position
	var direction := local_destination.normalized()
	navigation_agent.velocity = direction * 5.0

func _randomize_wander() -> void:
	var random_direction := Vector3(randf_range(-5, 5), npc.global_position.y, randf_range(-5,5))
	navigation_agent.set_target_position(random_direction)
	
	wander_time = randf_range(1, 3)
