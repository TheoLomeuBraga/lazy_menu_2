extends LazyRebind
class_name LazyRebindBuilder

@export var save_file_name : String = "lazy_menu_bingings"

enum KeyRebindTypes {Keyboard, Joystick}
@export var key_rebind_type : KeyRebindTypes

var lazy_rebind_key_packed_scene : PackedScene = preload("res://addons/lazy_menu_2/lazy_rebind/elements/key_rebinder.tscn")

static var base_binds : Dictionary = {}
static func get_current_binds() -> Dictionary:
	var ret : Dictionary = {}
	for k in InputMap.get_actions():
		for ae : InputEvent in InputMap.action_get_events(k):
			
			if not ret.has(k):
				ret[k] = []
			
			ret[k].push_back(ae)
	return ret

func update_texts() -> void:
	for c : LazyRebindElement in get_node("Base/VBoxContainer/Panel/ScrollContainer/VBoxContainer").get_children():
		c.update_button_text()

static func reset_default_binds(elements_area : Control = null) -> void:
	
	for k in base_binds:
		InputMap.action_erase_events(k)
		for e in base_binds[k]:
			InputMap.action_add_event(k,e)
			
	
	if elements_area == null:
		return
	
	for c : LazyRebindElement in elements_area.get_children():
		c.update_button_text()

static func save_binds(file_name : String) -> void:
	var save_file : FileAccess = FileAccess.open("user://" + file_name + ".bind", FileAccess.WRITE)
	
	save_file.store_var(get_current_binds(),true)
	

static func load_binds(file_name : String) -> Dictionary:
	
	if base_binds.size() == 0:
		base_binds = get_current_binds()
	
	var save_file : FileAccess = FileAccess.open("user://" + file_name + ".bind", FileAccess.READ)
	
	if save_file == null:
		return {}
	
	var bindi_dictionary : Variant = save_file.get_var(true)
	
	if bindi_dictionary == null:
		return {}
	
	for k in bindi_dictionary:
		InputMap.action_erase_events(k)
		for e in bindi_dictionary[k]:
			
			InputMap.action_add_event(k,e)
	
	return bindi_dictionary

signal exit()

func call_exit() -> void:
	load_binds(save_file_name)
	exit.emit()

func _ready() -> void:
	
	var elements_area : Control = get_node("Base/VBoxContainer/Panel/ScrollContainer/VBoxContainer")
	
	for k in InputMap.get_actions():
		
		if "ui_" in k:
			continue
		
		var key : LazyRebindElement = lazy_rebind_key_packed_scene.instantiate()
		
		key.action = k
		key.key_rebind_type = key_rebind_type
		key.name = k
		key.get_node("Label").text = k
		
		elements_area.add_child(key)
		
	
	var default_button : Button = get_node("Base/VBoxContainer/HBoxContainer/default")
	default_button.pressed.connect(reset_default_binds.bind(elements_area))
	
	get_node("Base/VBoxContainer/HBoxContainer/save").pressed.connect(save_binds.bind(save_file_name))
	
	get_node("Base/VBoxContainer/HBoxContainer/exit").pressed.connect(call_exit)
	
