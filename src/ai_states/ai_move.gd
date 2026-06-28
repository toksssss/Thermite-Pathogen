extends Node
class_name AIMove

@export var move_name : String
@export var animation : String

var player: Player
var character : CharacterBody3D
var params : NPCParameters
var animator : AnimationPlayer
var nav_agent : NavigationAgent3D
var weapon : AIWeaponStrategy
var marker : Marker3D
var collider : CollisionShape3D
var raycast : RayCast3D

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

func rotate_character(position : Vector3, speed: float, delta: float) -> void:
	var target := character.transform.looking_at(position)
	var weight : float = 1 - exp(-speed * delta)
	character.transform = lerp(character.transform, target, weight)

func distance_to_player() -> float:
	return character.global_position.distance_to(player.global_position)

func follow_target(speed: float, delta: float) -> void:
	if nav_agent.is_navigation_finished():
		character.velocity = Vector3.ZERO

	nav_agent.target_position = player.global_position
	var destination := nav_agent.get_next_path_position()
	var direction := (destination - character.global_position).normalized()
	nav_agent.velocity = direction * speed
