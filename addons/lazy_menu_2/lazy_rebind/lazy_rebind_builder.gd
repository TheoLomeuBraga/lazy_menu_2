extends LazyRebind
class_name LazyRebindBuilder

@export var save_file_name : String = "lazy_menu_bingings"

enum KeyRebindTypes {Keyboard, Joystick}
@export var key_rebind_type : KeyRebindTypes

var lazy_rebind_key_packed_scene : PackedScene = preload("res://addons/lazy_menu_2/lazy_rebind/elements/key_rebinder.tscn")

static var base_binds : Dictionary
static func process_base_binds() -> void:
	
	for k in InputMap.get_actions():
		for ae in InputMap.action_get_events(k):
			
			if not base_binds.has(k):
				base_binds[k] = []
			
			base_binds[k].push_back(ae)
	
	

static func save_binds(file_name : String) -> void:
	var save_file : FileAccess = FileAccess.open("user://" + file_name + ".cfg", FileAccess.WRITE)

static func load_binds(file_name : String) -> Dictionary:
	var save_file : FileAccess = FileAccess.open("user://" + file_name + ".cfg", FileAccess.READ)
	
	if base_binds.size() == 0:
		process_base_binds()
	
	return {}

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
		
		
		
		
