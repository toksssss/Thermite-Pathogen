@abstract
extends Node
class_name Move

#all move flags and variables here
var player : Player
@export var animation : String
var head_raycast : RayCast3D

var base_speed : float

var crouch_speed_multiplier : float
var walk_speed_multiplier : float
var slide_speed_multiplier : float

var acceleration : float
var deccelartion : float

static var moves_priority : Dictionary[String, int] = {
	"idle" : 1,
	"walk" : 2,
	"crouch" : 3,
	"jump" : 10,
	"falling" : 20
}

static func moves_priority_sort(a: String, b: String) -> bool:
	if moves_priority[a] > moves_priority[b]:
		return true
	return false

func set_crouch_collision_shape() -> void:
	player.crouch_collision.disabled = false
	player.stand_collision.disabled = true

func set_stand_collision_shape() -> void:
	player.crouch_collision.disabled = true
	player.stand_collision.disabled = false

@warning_ignore("unused_parameter")
func check_relevance(input: InputPackage) -> String:
	print_debug("error, implement the check_relevance function on your state")
	return "error, implement the check_relevance function on your state"

@warning_ignore("unused_parameter")
func update(input: InputPackage, delta: float) -> void:
	pass

func on_enter_state() -> void:
	pass

func on_exit_state() -> void:
	pass

@warning_ignore("unused_parameter")
func on_continious_exit_state(delta: float) -> void:
	pass

@warning_ignore("unused_parameter")
func on_continious_enter_state(delta: float) -> void:
	pass



# General Moves heir usage guide.

# > check_relevance function aims to be short and simple.
# 	Its general structure is as follows: 
#	if (move is ready to transition) :
#		transition to the highest priority out there
#	else:
#		return "okay" to save our managing status.
#
# 	Move readyness for transition is generally a simple function based on timings or statuses of the player.
#	If you are starting to understand that your transition readyness is a complex method, OR
# 	if you are tempted to add third branching operator into your check_relevance function,
#	seriously consider if Combo can do this logic for you, you won't regret its usage I promise.
#	(Combo is clickable even from comments btw)

# > update functions manages perframe behaviour of your Move.
#	There are two update types: constant change and a single dynamic update on some timing.
#	To implement simple constant changes, try to find some physics abstraction for them to make
#	engine work for you. If your constant changes are too complex, try to avoid hardcoding 
#	the behaviour into a giant update, better shove the changes data into a backend animation or
#	some other data structure resource.
#	To implement timed changes, use a flag and work with timings via get_progress() and Co.
#	To roughly base your internal timings on the players behaviour, you can check skeleton
#	animation for reference. But for the love of god please avoid referensing skeleton and animator
#	in any shape way or form in the Moves code directly. This way your Move "backend" is free from
#	thousand different ways someone (probably you from the future) can mess up your skeleton, scene composition,
#	animations, names libraries etc.
