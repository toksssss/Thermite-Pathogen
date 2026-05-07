# Класс для передачи данных об атаке между, например, Hurtbox и Hitbox
class_name AttackData

# Информация

enum OWNER_TYPE {PLAYER, ENEMIE, NPC}

var owner : OWNER_TYPE

var source : WeaponStrategy

var kill_count : int

# Статы

var damage : float

# knockback, fire, ice etc.
