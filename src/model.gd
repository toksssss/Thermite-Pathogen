extends Node3D
class_name PlayerModel

@onready var player : Player = $".."
@onready var skeleton : Skeleton3D = %GeneralSkeleton
#@onready var animator : AnimationPlayer = $SkeletonAnimator\

var current_move : Move
var movement_upgrades : ReactiveArray

# All move stats here:
@export var walk_speed := 10.0

@onready var moves: Dictionary[String, Move] = {
	"idle" : $Idle,
	"walk" : $Walk,
	"jump" : $Jump,
	"falling" : $Falling
}

func _ready() -> void:
	movement_upgrades = ReactiveArray.new()
	movement_upgrades.value = []
	movement_upgrades.value.append(SpeedMovementStrategy.new())
	movement_upgrades.reactive_changed.connect(_on_movement_strategy_changed)
	for i : BaseMovementStrategy in movement_upgrades.value:
		i.apply_upgrade(self)
	
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
	print("Switch from %s to %s" % [current_move.name, state])
	current_move.on_exit_state()
	current_move = moves[state]
	current_move.on_enter_state()
	#animator.play(current_move.animation)

func _on_movement_strategy_changed(v: ReactiveArray) -> void:
	for i : BaseMovementStrategy in v.values:
		i.apply_upgrade(self)
