extends Node
class_name PlayerAbilitiesManager

signal ability_changed(value: PlayerAbilityStrategy)

@onready var player : Player = $".."

@export_category("Abilities")
@export var starting_ability : PlayerAbilityStrategy
@export var abilities : Array[PlayerAbilityStrategy]

func _ready() -> void:
	ability_changed.connect(_on_ability_changed)

func _apply_passive_abilities() -> void:
	for ability: PlayerAbilityStrategy in abilities:
		ability.apply_strategy(player)

func try_to_use_ability(input: InputPackage) -> void:
	# Надо бы покрасивше потом сделать
	if input.ability_actions.has("ability_prime"):
		starting_ability.apply_strategy(player)
	
	if input.ability_actions.has("ability_1"):
		abilities[0].apply_strategy(player)
	if input.ability_actions.has("ability_2"):
		abilities[1].apply_strategy(player)
	if input.ability_actions.has("ability_3"):
		abilities[2].apply_strategy(player)
	if input.ability_actions.has("ability_4"):
		abilities[3].apply_strategy(player)

@warning_ignore("unused_parameter")
func _on_ability_changed(ability: PlayerAbilityStrategy) -> void:
	pass
