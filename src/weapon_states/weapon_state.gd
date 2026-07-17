@abstract
extends Node
class_name WeaponState

@export var state_name : String = "idle"
@export var priority : int = 1

#all move flags and variables here
@export_category("Stats")
@export var ammo_cost : int
@export var kill_cost : int

@export_category("Animations")
@export var weapon_animation : StringName

var animation_duration : float
var animation_length : float = 0.0
var current_weapon : WeaponStrategy
var weapon_model : WeaponModel
var melee_hurtbox : ManualHurtbox
var enter_state_time : float
var resources : WeaponResourcesStore
var timer : Timer

var animation_speed : float

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

func works_longer_than(time : float) -> bool:
	if get_progress() >= time:
		return true
	return false

func get_progress() -> float:
	var now : float = Time.get_unix_time_from_system()
	return now - enter_state_time

func mark_enter_state() -> void:
	enter_state_time = Time.get_unix_time_from_system()

func best_input_that_can_be_paid(input: InputPackage) -> String:
	input.combat_actions.sort_custom(custom_sort_actions)
	for action in input.combat_actions:
		if current_weapon.can_be_paid(weapon_model.states[action]):
			return action
	return "error, even idle state is not presented" 

func custom_sort_actions(a: String, b: String) -> bool:
	if weapon_model.states[a].priority > weapon_model.states[b].priority:
		return true
	return false

func start_timer(cooldown: float) -> void:
	timer.start(cooldown)
	current_weapon.is_cooldown = true
	timer.timeout.connect(func () -> void: current_weapon.is_cooldown = false)

# General States heir usage guide.

# > check_relevance function aims to be short and simple.
# 	Its general structure is as follows: 
#	if (state is ready to transition) :
#		transition to the highest priority out there
#	else:
#		return "okay" to save our managing status.
#
# 	Move readyness for transition is generally a simple function based on timings or statuses of the player.
#	If you are starting to understand that your transition readyness is a complex method, OR
# 	if you are tempted to add third branching operator into your check_relevance function,
#	seriously consider if Combo can do this logic for you, you won't regret its usage I promise.

# > update functions manages perframe behaviour of your State.
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
