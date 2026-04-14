extends Node3D
class_name PlayerModel

@onready var player : Player = $".."
@onready var skeleton : Skeleton3D = %GeneralSkeleton
#@onready var animator : AnimationPlayer = $SkeletonAnimator

var current_move : Move
var movement_upgrades : ReactiveArray

# All move stats here:
@export var walk_speed := 10.0

# Вместо ручного вписывания заменить на "for child in get_children()"
@onready var moves: Dictionary[String, Move] = {
	"idle" : $States/Idle,
	"walk" : $States/Walk,
	"jump" : $States/Jump,
	"falling" : $States/Falling
}

func _ready() -> void:
	_init_movement_upgrade()
	
	current_move = moves["idle"]
	for move : Move in moves.values():
		move.player = player
		move.walk_speed = walk_speed

func update(input: InputPackage, delta: float) -> void:
	#apply all upgrades
	#for strategy : BaseMovementStategy in movement_upgrades:
		 #strategy.apply_upgrade(self)
	
	var relevance : String = current_move.check_relevance(input)
	if relevance != "okay":
		switch_to(relevance)
	current_move.update(input, delta)

func switch_to(state: String) -> void:
	if current_move == moves[state]:
		return

	current_move.on_exit_state()
	current_move = moves[state]
	current_move.on_enter_state()
	print("Switch from %s to %s" % [current_move.name, state])
	#animator.play(current_move.animation)

func _on_movement_strategy_changed(v: ReactiveArray) -> void:
	# Скорее всего надо будет переделать
	for strategy : BaseMovementStrategy in v.values:
		strategy.apply_upgrade(self)
		
func _init_movement_upgrade() -> void:
	movement_upgrades = ReactiveArray.new()
	movement_upgrades.value = []
	movement_upgrades.value.append(SpeedMovementStrategy.new())
	movement_upgrades.reactive_changed.connect(_on_movement_strategy_changed)

	for strategy: BaseMovementStrategy in movement_upgrades.value:
		strategy.apply_upgrade(self)
