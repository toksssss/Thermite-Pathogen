extends Node3D
class_name PlayerModel

@onready var player : Player = $".."
@onready var skeleton : Skeleton3D = %GeneralSkeleton
@export var head_checker : RayCast3D
#@onready var animator : AnimationPlayer = $SkeletonAnimator
@export var states_group : Node
@export var velocity_component : VelocityComponent

var current_move : Move
var movement_upgrades : ReactiveArray

# All move stats here:
@export_category("Move Stats")
@export var base_speed := 10.0

@export var walk_speed_multiplier : float = 1.0
@export var crouch_speed_multiplier : float = 0.5
@export var slide_speed_multiplier : float = 2.0

@export var acceleration : float = 12
@export var deccelartion : float = 18

@onready var moves: Dictionary[String, Move] = {}

func _ready() -> void:
	_init_moves()
	#_init_movement_upgrade()
	
	current_move = moves["idle"]
	for move : Move in moves.values():
		move.player = player
		move.head_raycast = head_checker
		move.base_speed = base_speed
		move.walk_speed_multiplier = walk_speed_multiplier
		move.crouch_speed_multiplier = crouch_speed_multiplier
		move.slide_speed_multiplier = slide_speed_multiplier
		move.vel_comp = velocity_component

func update(input: InputPackage, delta: float) -> void:
	#apply all upgrades
	#for strategy : BaseMovementStategy in movement_upgrades:
		 #strategy.apply_upgrade(self)
	
	var relevance : String = current_move.check_relevance(input)
	if relevance != "okay":
		switch_to(relevance, delta)
	current_move.update(input, delta)

func switch_to(state: String, delta: float) -> void:
	if current_move == moves[state]:
		return

	#print("Switch from %s to %s" % [current_move.name, state])
	current_move.on_exit_state()
	current_move.on_continious_exit_state(delta)
	current_move = moves[state]
	current_move.on_enter_state()
	current_move.on_continious_enter_state(delta)
	#if current_move.animation: 
		#animator.play(current_move.animation)

func _on_movement_strategy_changed(v: ReactiveArray) -> void:
	# Скорее всего надо будет переделать
	for strategy : BaseMovementStrategy in v.value:
		strategy.apply_upgrade(self)

func _init_movement_upgrade() -> void:
	movement_upgrades = ReactiveArray.new()
	movement_upgrades.value = []
	movement_upgrades.value.append(SpeedMovementStrategy.new())
	movement_upgrades.reactive_changed.connect(_on_movement_strategy_changed)

	for strategy: BaseMovementStrategy in movement_upgrades.value:
		strategy.apply_upgrade(self)

func _init_moves() -> void:
	for child in states_group.get_children():
		if child is Move:
			moves[child.name.to_lower()] = child
