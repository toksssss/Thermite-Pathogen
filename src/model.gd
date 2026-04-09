extends Node3D
class_name PlayerModel

@onready var player : Player = $".."
@onready var skeleton : Skeleton3D = %GeneralSkeleton
#@onready var animator : AnimationPlayer = $SkeletonAnimator

var current_move : Move

@onready var moves: Dictionary[String, Move] = {
	"idle" : $Idle,
	"walk" : $Walk,
	"jump" : $Jump,
	"falling" : $Falling
}

func _ready() -> void:
	current_move = moves["idle"]
	for move in moves.values():
		move.player = player

func update(input: InputPackage, delta: float) -> void:
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
