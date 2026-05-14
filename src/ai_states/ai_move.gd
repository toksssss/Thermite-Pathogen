extends Node
class_name AIMove

@export var move_name : String
@export var animation : String

var player: Player
var character : CharacterBody3D
var animator : AnimationPlayer
var nav_agent : NavigationAgent3D

var enter_state_time : float


func check_transition(delta: float) -> String:
	return "implement move for " + move_name


func update(delta: float) -> void:
	pass
 

func on_enter() -> void:
	pass


func on_exit() -> void:
	pass


# our little timestamps framework to work with timings inside our logic
func mark_enter_state() -> void:
	enter_state_time = Time.get_unix_time_from_system()


func get_progress() -> float:
	var now : float = Time.get_unix_time_from_system()
	return now - enter_state_time


func works_longer_than(time : float) -> bool:
	if get_progress() >= time:
		return true
	return false


func works_less_than(time : float) -> bool:
	if get_progress() < time: 
		return true
	return false


func works_between(start : float, finish : float) -> bool:
	var progress : float = get_progress()
	if progress >= start and progress <= finish:
		return true
	return false
