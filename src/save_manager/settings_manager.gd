class_name SettingsManager

static var config : ConfigFile = ConfigFile.new()
const CFG_PATH := &"user://settings.ini"

#func create_user_config() -> void:
	#config = ConfigFile

static func load_user_config() -> Error:
	var e := config.load(CFG_PATH)
	if e != OK:
		print_debug("Error when loading user config. Creating")
		save_user_config()
	return e

static func save_user_config() -> Error:
	var e:= config.save(CFG_PATH)
	if e != OK:
		print_debug("Error when creating/saving user config")
	return e

static func set_value_to_config(section: String, key: String, value: Variant) -> void:
	config.set_value(section, key, value)

static func get_value_from_config(section: String, key: String, default: Variant = null) -> Variant:
	return config.get_value(section, key, default)

static func clear_config() -> void:
	config.clear()

static func clear_and_save_config() -> void:
	config.clear()
	save_user_config()
