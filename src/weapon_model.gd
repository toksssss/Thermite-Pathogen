extends Node3D
class_name WeaponModel

@onready var player : Player = $"../.."

@export var initial_weapon_strategy : WeaponStrategy
@export var viewmodel_rig : Node3D

var current_state : WeaponState
var weapon_upgrades : ReactiveArray
var current_weapon_strategy : WeaponStrategy
var current_weapon_viewmodel : Node3D
var marker : Marker3D

var animator : AnimationPlayer

# All state stats here:

# Вместо ручного вписывания заменить на "for child in get_children()"
@onready var states: Dictionary[String, WeaponState] = {
	"idle" : $Idle,
	"reload" : $Reload,
	"fire" : $Fire
}

func _ready() -> void:
	#_init_weapon_upgrade()

	_setup_weapon()
	_setup_animator()
	
	marker = current_weapon_viewmodel.get_node_or_null("Marker3D")
	
	current_state = states["idle"]
	for state : WeaponState in states.values():
		state.current_weapon = current_weapon_strategy
		state.weapon_model = self

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
	if current_state.animation:
		animator.play(current_state.animation)

func _setup_animator() -> void:
	animator = current_weapon_viewmodel.get_node_or_null("AnimationPlayer")

func _setup_weapon() -> void:
	current_weapon_strategy = initial_weapon_strategy
	current_weapon_viewmodel = current_weapon_strategy.weapon_resource.weapon_scene.instantiate()
	current_weapon_viewmodel.position = current_weapon_strategy.weapon_resource.position
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
