extends StateMachine
class_name AEDStateMachine

@export var navigation_agent : NavigationAgent3D
@export var weapon : AIWeaponStrategy
@export var marker : Marker3D
@export var collider : CollisionShape3D
@export var raycast : RayCast3D

func _ready() -> void:
	navigation_agent.velocity_computed.connect(
		func(v: Vector3) -> void: character.velocity = v
		)
	accept_states()
	super._ready()

func accept_states() -> void:
	for child in get_children():
		if child is AIMove:
			var move : AIMove = child as AIMove
			moves[move.move_name] = child
			move.animator = animation_player
			move.character = character
			move.player = get_tree().get_first_node_in_group("player")
			move.nav_agent = navigation_agent
			move.weapon = weapon
			move.marker = marker
			move.collider = collider
			move.raycast = raycast
