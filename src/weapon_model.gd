extends Node3D
class_name WeaponModel

@onready var player : Player = $"../.."
@export var state_node : Node

@export_group("Weapon")
@export var initial_weapon_strategy : WeaponStrategy

@export_group("Viewmodel")
@export var viewmodel_rig : Node3D

@export_group("Melee")
@export var melee_animator : AnimationPlayer
@export var melee_hurtbox : ManualHurtbox

@export_category("Marker")
@export var marker : Marker3D

var current_state : WeaponState
var weapon_upgrades : ReactiveArray
var current_weapon_strategy : WeaponStrategy:
	set(v):
		current_weapon_strategy = v
		setup_weapon()
		for s: WeaponState in states.values():
			s.current_weapon = current_weapon_strategy

var current_weapon_viewmodel : Node3D
var weapon_animator : AnimationPlayer

# All state stats here:

@onready var states: Dictionary[String, WeaponState] = {}

func _ready() -> void:
	#_init_weapon_upgrade()
	_init_states()
	current_weapon_strategy = initial_weapon_strategy

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
	#if current_state == states[new_state]:
		#return

	print("Weapon State: switch from %s to %s" % [current_state.name, new_state])
	current_state.on_exit_state()
	current_state = states[new_state]
	current_state.on_enter_state()
	current_state.mark_enter_state()
	if weapon_animator and current_state.weapon_animation:
		weapon_animator.play(current_state.weapon_animation, -1, current_state.animation_speed)

func setup_weapon() -> void:
	current_weapon_strategy._current_bullets = current_weapon_strategy.weapon_data.bullet_capacity
	
	_setup_weapon_viewmodel()
	_setup_weapon_animator()

func _setup_weapon_viewmodel() -> void:
	current_weapon_viewmodel = current_weapon_strategy.weapon_data.weapon_scene.instantiate()
	current_weapon_viewmodel.position = current_weapon_strategy.weapon_data.position
	current_weapon_viewmodel.rotation_degrees = current_weapon_strategy.weapon_data.rotation
	current_weapon_viewmodel.scale = current_weapon_strategy.weapon_data.scale
	
	for c : Node in viewmodel_rig.get_children():
		c.queue_free()
	Utils.add_child_safe(current_weapon_viewmodel, viewmodel_rig)

func _setup_in_editor() -> void:
	current_weapon_viewmodel = initial_weapon_strategy.weapon_data.weapon_scene.instantiate()
	current_weapon_viewmodel.position = initial_weapon_strategy.weapon_data.position
	current_weapon_viewmodel.rotation_degrees = initial_weapon_strategy.weapon_data.rotation
	current_weapon_viewmodel.scale = initial_weapon_strategy.weapon_data.scale
	
	for c : Node in viewmodel_rig.get_children():
		c.queue_free()
	Utils.add_child_safe(current_weapon_viewmodel, viewmodel_rig)

func _setup_weapon_animator() -> void:
	weapon_animator = current_weapon_viewmodel.get_node_or_null("AnimationPlayer")
	if weapon_animator == null:
		push_warning("Weapons AnimationPlayer has not found")

func _init_states() -> void:
	for state in state_node.get_children():
		if state is WeaponState:
			states[state.name.to_lower()] = state
			state.weapon_model = self
			state.melee_hurtbox = melee_hurtbox
	current_state = states["idle"]

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
