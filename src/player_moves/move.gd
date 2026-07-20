@abstract
extends Node
class_name Move

#all move flags and variables here
var player : Player
@export var animation : String
var head_raycast : RayCast3D
var foot_raycast : RayCast3D
var vel_comp : VelocityComponent

var base_speed : float

var crouch_speed_multiplier : float
var walk_speed_multiplier : float
var slide_boost_speed_multiplier : float

# Audio

const STEP_EVENT_GUID := "{447525d9-f923-426e-aa77-30467c352461}"

static var sound_event : FmodEvent

const footstep_timer_reset : float = 0.25
static var footstep_timer : float = 0.0

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

func footstep_sound(delta: float) -> void:
	if !sound_event:
		sound_event = FmodServer.create_event_instance_with_guid(STEP_EVENT_GUID)
	
	if footstep_timer <= 0.0:
		if foot_raycast.is_colliding():
			#var obj := foot_raycast.get_collider()
			#match obj.surface_type:
				#"Grass":
					#sound_event.set_parameter_by_name("SurfaceType", 0.0)
				#"Wood":
					#sound_event.set_parameter_by_name("SurfaceType", 1.0)
				#"Metal":
					#sound_event.set_parameter_by_name("SurfaceType", 2.0)
				#"Water":
					#sound_event.set_parameter_by_name("SurfaceType", 3.0)
				#"Stone":
					#sound_event.set_parameter_by_name("SurfaceType", 4.0)
				#_:
					#sound_event.set_parameter_by_name("SurfaceType", 4.0)
			sound_event.set_parameter_by_name("SurfaceType", 4.0)
			sound_event.set_3d_attributes(player.global_transform)
			sound_event.set_volume(0.15)
			sound_event.start()
			footstep_timer = footstep_timer_reset
	else:
		footstep_timer -= delta

func play_footstep_sound() -> void:
	if !sound_event:
		sound_event = FmodServer.create_event_instance_with_guid(STEP_EVENT_GUID)
	
	if foot_raycast.is_colliding():
		#var obj := foot_raycast.get_collider()
		#match obj.surface_type:
			#"Grass":
				#sound_event.set_parameter_by_name("SurfaceType", 0.0)
			#"Wood":
				#sound_event.set_parameter_by_name("SurfaceType", 1.0)
			#"Metal":
				#sound_event.set_parameter_by_name("SurfaceType", 2.0)
			#"Water":
				#sound_event.set_parameter_by_name("SurfaceType", 3.0)
			#"Stone":
				#sound_event.set_parameter_by_name("SurfaceType", 4.0)
			#_:
				#sound_event.set_parameter_by_name("SurfaceType", 4.0)
		sound_event.set_parameter_by_name("SurfaceType", 4.0)
		sound_event.set_3d_attributes(player.global_transform)
		sound_event.start()

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
