extends LazyConsole
class_name LazyConsoleBuilder

var console_element_packed_scene : PackedScene = preload("res://addons/lazy_menu_2/lazy_console/element/element.tscn")

var container : VBoxContainer
var input_area : LineEdit
var schrol_container : ScrollContainer

func go_to_bottom() -> void:
	await get_tree().create_timer(0.01).timeout
	schrol_container.scroll_vertical = container.size.y

signal cmd_submitted(Array)

var cmd_history : Array[String]
var cmd_history_position : int = 0

func clear() -> void:
	for c in container.get_children():
		c.queue_free()

func echo(text : String) -> void:
	var t : RichTextLabel = console_element_packed_scene.instantiate()
	t.text = text
	container.add_child(t)
	
	
	

func process_raw_cmd(rcmd : String) -> void:
	
	cmd_history.push_back(rcmd)
	cmd_history_position += cmd_history.size()
	
	input_area.text = ""
	input_area.grab_focus()
	
	cmd_submitted.emit(rcmd.split(" "))
	
	call_deferred("go_to_bottom")
	

func _ready() -> void:
	
	container = get_node("Base/VBoxContainer/ScrollContainer/VBoxContainer")
	schrol_container = get_node("Base/VBoxContainer/ScrollContainer")
	input_area = get_node("Base/VBoxContainer/LineEdit")
	
	input_area.text_submitted.connect(process_raw_cmd)

func _process(delta: float) -> void:
	if cmd_history.size() > 0:
		if Input.is_action_just_pressed("ui_up"):
			cmd_history_position -= 1
			
			
			
	
	if Input.is_action_just_pressed("ui_down"):
		cmd_history_position += 1
		
		
		
	
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
		if cmd_history_position >= 0 and cmd_history_position < cmd_history.size():
			input_area.text = cmd_history[cmd_history_position]
			input_area.select()
			
	
	if cmd_history_position < 0:
		cmd_history_position = 0
	if cmd_history_position >= cmd_history.size():
		cmd_history_position = cmd_history.size()
