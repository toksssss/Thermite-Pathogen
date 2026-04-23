extends Node
class_name PlayerAbilitiesManager

signal ability_changed(value: BasePlayerAbilityStrategy)

@onready var player : Player = $".."

@export_category("Abilities")
@export var starting_ability : BasePlayerAbilityStrategy
@export var abilities : Array[BasePlayerAbilityStrategy]:
	set(v):
		if abilities.size() <= 4:
			abilities.append(v)
			ability_changed.emit(v)

var passive_abilities : Array[BasePlayerAbilityStrategy]
var active_abilities: Array[BasePlayerAbilityStrategy]

# w.i.p
var reserved_slot : BasePlayerAbilityStrategy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ability_changed.connect(_on_ability_changed)
	
	# Как будто хуйня а не проверка
	if starting_ability.behavior.type == starting_ability.behavior.AbilityType.PASSIVE:
		passive_abilities.append(starting_ability)
	else:
		reserved_slot = starting_ability

func _apply_passive_abilities() -> void:
	for ability: BasePlayerAbilityStrategy in passive_abilities:
		ability.apply_strategy(player)

func _apply_active_ability(input: InputPackage) -> void:
	# Надо бы покрасивше потом сделать
	if Input.is_action_just_pressed("btn_ability_start"):
		if reserved_slot:
			reserved_slot.apply_strategy(player)
	
	if input.ability_actions.has("ability_1"):
		active_abilities[0].apply_strategy(player)
	if input.ability_actions.has("ability_2"):
		active_abilities[1].apply_strategy(player)
	if input.ability_actions.has("ability_3"):
		active_abilities[2].apply_strategy(player)
	if input.ability_actions.has("ability_4"):
		active_abilities[3].apply_strategy(player)

func _on_ability_changed(ability: BasePlayerAbilityStrategy) -> void:
	pass
