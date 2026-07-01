extends Control
class_name LoadingScreen

static var instance : LoadingScreen:
	get:
		return GameManager.instance.loading_screen

var tween : Tween

func _ready() -> void:
	modulate.a = 0
	visible = false

func fade_in() -> void:
	if visible:
		return
	visible = true
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.3)
	await tween.finished

func fade_out(instant: bool = false) -> void:
	if !visible:
		return
	
	if instant:
		modulate.a = 0.0
		visible = false
		return
	
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	await tween.finished
	visible = false
