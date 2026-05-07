#@tool
extends Node3D
class_name WeaponModel

@onready var player : Player = $"../.."
@onready var weapon_resources : WeaponResourcesStore = $WeaponResources

@export_group("Weapon")
@export var initial_weapon_strategy : WeaponStrategy
	#set(v):
		#initial_weapon_strategy = v
		#if Engine.is_editor_hint():
			#_setup_weapon()
@export_group("Viewmodel")
@export var viewmodel_rig : Node3D
@export_group("Melee")
@export var melee_animator : AnimationPlayer
@export var melee_hurtbox : Hurtbox

var current_state : WeaponState
var weapon_upgrades : ReactiveArray
var current_weapon_strategy : WeaponStrategy
var current_weapon_viewmodel : Node3D
#var marker : Marker3D
@export var marker : Marker3D
var weapon_animator : AnimationPlayer

# All state stats here:

# Вместо ручного вписывания заменить на "for child in get_children()"
@onready var states: Dictionary[String, WeaponState] = {
	"idle" : $States/Idle,
	"reload" : $States/Reload,
	"fire" : $States/Fire,
	"melee" : $States/Melee
}

func _ready() -> void:
	#_init_weapon_upgrade()

	_setup_weapon()
	_setup_weapon_animator()
	
	melee_hurtbox.monitoring = false
	#marker = current_weapon_viewmodel.get_node_or_null("Marker3D")
	
	
	current_state = states["idle"]
	for state : WeaponState in states.values():
		state.current_weapon = current_weapon_strategy
		state.weapon_model = self
		state.melee_hurtbox = melee_hurtbox
		state.resources = weapon_resources

func update(input: InputPackage, delta: float) -> void:
	#apply all upgrades
	#for strategy : BaseMovementStategy in movement_upgrades:
		 #strategy.apply_upgrade(self)

	# input = contextualize_combat(input)
	var relevance : String = current_state.check_relevance(input)
	if relevance != "okay":
		switch_to(relevance)
	current_state.update(input, delta)

func switch_to(new_state: String) -> void:
	if current_state == states[new_state]:
		return

	#print("Weapon State: switch from %s to %s" % [current_state.name, new_state])
	current_state.on_exit_state()
	current_state = states[new_state]
	current_state.on_enter_state()
	current_state.mark_enter_state()
	if weapon_animator and current_state.weapon_animation:
		weapon_animator.play(current_state.weapon_animation)
	if current_state.arms_animation:
		melee_animator.play(current_state.arms_animation)

func _setup_weapon_animator() -> void:
	weapon_animator = current_weapon_viewmodel.get_node_or_null("AnimationPlayer")
	if weapon_animator == null:
		push_warning("Weapons AnimationPlayer has not found")

func _setup_weapon() -> void:
	current_weapon_strategy = initial_weapon_strategy
	
	weapon_resources.max_bullets = current_weapon_strategy.weapon_resource.bullet_capacity
	weapon_resources._current_bullets = current_weapon_strategy.weapon_resource.bullet_capacity
	current_weapon_strategy.kill_count_changed.connect(weapon_resources.update_kill_count)
	
	current_weapon_viewmodel = current_weapon_strategy.weapon_resource.weapon_scene.instantiate()
	current_weapon_viewmodel.position = current_weapon_strategy.weapon_resource.position
	current_weapon_viewmodel.rotation_degrees = current_weapon_strategy.weapon_resource.rotation
	current_weapon_viewmodel.scale = current_weapon_strategy.weapon_resource.scale
	
	viewmodel_rig.add_child(current_weapon_viewmodel)

#func _on_movement_strategy_changed(v: ReactiveArray) -> void:
	## Скорее всего надо будет переделать
	#for strategy : BaseWeaponStrategy in v.values:
		#strategy.apply_upgrade(self)
		
#func _init_weapon_upgrade() -> void:
	#weapon_upgrades = ReactiveArray.new()
	#weapon_upgrades.value = []
	#weapon_upgrades.value.append(SpeedMovementStrategy.new())
	#weapon_upgrades.reactive_changed.connect(_on_movement_strategy_changed)
#
	#for strategy: BaseWeaponStrategy in weapon_upgrades.value:
		#strategy.apply_upgrade(self)
