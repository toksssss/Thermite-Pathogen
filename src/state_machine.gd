@abstract
extends Node
class_name StateMachine

@export var animation_player : AnimationPlayer
@export var character : CharacterBody3D

var BLENDING_TIME : float = 0.5

var moves : Dictionary[String, AIMove] # { String : AIMove }
var current_move : AIMove


func _ready() -> void:
	current_move = moves["idle"]
	switch_to("idle")


func _physics_process(delta: float) -> void:
	var verdict : String = current_move.check_transition(delta)
	if verdict != "okay":
		switch_to(verdict)
	current_move.update(delta)
	character.move_and_slide()


func switch_to(next_state_name : String) -> void:
	print(current_move.move_name + " -> " + next_state_name)
	current_move.on_exit()
	current_move = moves[next_state_name]
	current_move.mark_enter_state()
	current_move.on_enter()
	animation_player.stop()
	animation_player.play(current_move.animation, BLENDING_TIME)
