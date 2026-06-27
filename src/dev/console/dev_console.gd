extends CanvasLayer
class_name DevConsole

static var instance: DevConsole:
	get:
		if GameManager.instance == null:
			return instance
		return GameManager.instance.dev_console

var exit_button : Button
var submit_button : Button
var command_line : LineEdit
var console_output : RichTextLabel

var console_manager : DevConsoleManager

var m_mode : Input.MouseMode

func _ready() -> void:
	if GameManager.instance == null:
		instance = self
	console_manager = DevConsoleManager.new()
	ConsoleCommandsRegister.register_commands()
	console_manager.console = self
	exit_button = %ExitButton
	exit_button.button_down.connect(close)
	submit_button = %SubmitButton
	submit_button.button_down.connect(on_submit_button_down)
	command_line = %CommandPromt
	command_line.text_submitted.connect(on_command_line_text_sumbitted)
	console_output = %ConsoleOutput
	console_output.text = ""

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("btn_console_open"):
		if !visible:
			open()
		else:
			close()
	if visible:
		if event is InputEventAction:
			get_viewport().set_input_as_handled()
			if Input.is_action_just_pressed("btn_console_up"):
				if console_manager.command_history_index < len(console_manager.command_history) - 1:
					console_manager.command_history_index += 1
					command_line.text = console_manager.command_history[console_manager.command_history_index]
			if Input.is_action_just_pressed("btn_console_down"):
				if console_manager.command_history_index > -1:
					console_manager.command_history_index -= 1
					if console_manager.command_history_index == -1:
						command_line.text = ""
					else:
						command_line.text = console_manager.command_history[console_manager.command_history_index]

func open() -> void:
	visible = true
	m_mode = Input.mouse_mode
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if GameplayManager.instance != null:
		GameplayManager.instance.ui_counter += 1
 
func close() -> void:
	visible = false
	Input.mouse_mode = m_mode
	if GameplayManager.instance != null:
		GameplayManager.instance.ui_counter -= 1

func on_submit_button_down() -> void:
	var raw_command : String = command_line.text
	if raw_command == "": return
	command_line.text = ""
	console_manager.run_command(raw_command)

func on_command_line_text_sumbitted(raw_command: String) -> void:
	if raw_command == "": return
	command_line.text = ""
	console_manager.run_command(raw_command)

func console_print_log(text: String) -> void:
	console_output.text += text
