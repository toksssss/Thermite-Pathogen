extends Control
class_name LoadingScreen

static var instance : LoadingScreen:
	get:
		return GameManager.instance.loading_screen

var tween : Tween

func fade_in() -> void:
	visible = true
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.3)
	await tween.finished

func fade_out(instant: bool = false) -> void:
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
