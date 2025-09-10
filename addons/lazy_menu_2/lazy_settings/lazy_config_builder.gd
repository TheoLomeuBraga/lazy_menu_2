extends LazySettings
class_name LazySettingsBuilder

@export var save_file_name : String = "lazy_menu_settings"
@export var menu_items : Array[LazySettingsItemBase]

signal exit()

static func load_data_dictionary(file_name : String) -> Dictionary:
	var save_file : FileAccess = FileAccess.open("user://" + file_name + ".cfg", FileAccess.READ)
	
	if save_file == null:
		return {}
	
	return save_file.get_var()

func set_base_value() -> void:
	for c in $Base/VBoxContainer/Panel/ScrollContainer/VBoxContainer.get_children():
		if c is LazySettingsElement:
			c._set_value(c.get_meta("base_value")) 

func save() -> void:
	var data_dictionary : Dictionary
	for c in $Base/VBoxContainer/Panel/ScrollContainer/VBoxContainer.get_children():
		if c is LazySettingsElement:
			data_dictionary[c.name] = c._get_value()
		
	
	var save_file : FileAccess = FileAccess.open("user://" + save_file_name + ".cfg", FileAccess.WRITE)
	save_file.store_var(data_dictionary)

func load_data() -> void:
	var save_file : FileAccess = FileAccess.open("user://" + save_file_name + ".cfg", FileAccess.READ)
	
	if save_file == null:
		return
	
	var data_dictionary : Dictionary = save_file.get_var()
	
	for c in $Base/VBoxContainer/Panel/ScrollContainer/VBoxContainer.get_children():
		if c is LazySettingsElement:
			c._set_value(data_dictionary[c.name])



func _ready() -> void:
	$Base/VBoxContainer/HBoxContainer/save.pressed.connect(save)
	$Base/VBoxContainer/HBoxContainer/default.pressed.connect(set_base_value)
	$Base/VBoxContainer/HBoxContainer/exit.pressed.connect(exit.emit)
	load_data()
