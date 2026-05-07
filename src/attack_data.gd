# Класс для передачи данных об атаке между, например, Hurtbox и Hitbox
class_name AttackData

# Информация

enum SOURCE_TYPE {PLAYER, ENEMIE, NPC}

var source : SOURCE_TYPE

# Статы

var damage : float

# knockback, fire, ice etc.
