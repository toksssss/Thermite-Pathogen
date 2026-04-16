extends Move

func check_relevance(input: InputPackage) -> String:
	return ""

func update(input: InputPackage, delta: float) -> void:
	pass

func on_enter_state() -> void:
	(player.collision.shape as CapsuleShape3D).height *= 0.5
	
	

func on_exit_state() -> void:
	(player.collision.shape as CapsuleShape3D).height *= 2
