extends EnemiesState

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if !npc or !player:
		return
		
	navigation_agent.target_position = player.global_position
	
	var distance := player.global_position - npc.global_position
	if distance.length() >= 20:
		transitioned.emit(self, "idle")
	
	if navigation_agent.is_navigation_finished():
		npc.velocity = Vector3.ZERO
		return
	
	var destination := navigation_agent.get_next_path_position()
	var direction := (destination - npc.global_position).normalized()
	navigation_agent.velocity = direction * 2.0
