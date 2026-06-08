extends CharacterBody3D
class_name AED_P1

# Сделать абстракцию условно EnemyNPC, чтоб в нем были все этим атрибуты.
# И заменить <>_trigger на flag1, flag2, flag3, flag4 и т.д 

@export var follow_trigger : int = 30
@export var melee_trigger : float = 3.0
@export var idle_trigger : float = 30.0
@export var speed : float = 2.0
@export var rotate_speed : float = 6.0
@export var melee_damage : float = 10.0
@export var bullet_damage : float = 10.0
