extends Reactive
class_name ReactiveArray

var value : Array:
	set(v):
		value = v
		reactive_changed.emit(self)
		return value

func _init(initial_value : Array = []) -> void:
	value = initial_value

func append(v : Variant) -> void:
	value.append(v)
	reactive_changed.emit(self)

func errase(v : Variant) -> void:
	value.erase(v)
	reactive_changed.emit(self)
