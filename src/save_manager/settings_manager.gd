class_name SettingsManager

static var config : ConfigFile = ConfigFile.new()

#func create_user_config() -> void:
	#config = ConfigFile

func load_user_config() -> Error:
	var e := config.load("user://settings.ini")
	if e != OK:
		print_debug("Error when loading user config")
	return e

func save_user_config() -> Error:
	var e:= config.save("user://settings.ini")
	if e != OK:
		print_debug("Error when saving user config")
	return e

func set_value_to_config(section: String, key: String, value: Variant) -> void:
	config.set_value(section, key, value)

func get_value_from_config(section: String, key: String, default: Variant = null) -> Variant:
	return config.get_value(section, key, default)
