@icon("res://addons/lazy_menu_2/icon.svg")
@tool

extends EditorPlugin

var lazy_menu_base_packed_scene : PackedScene = preload("res://addons/lazy_menu_2/lazy_settings/base/base.tscn")
var lazy_menu_check_box_packed_scene : PackedScene = preload("res://addons/lazy_menu_2/lazy_settings/elements/check_box/check_box.tscn")
var lazy_menu_check_button_packed_scene : PackedScene = preload("res://addons/lazy_menu_2/lazy_settings/elements/check_button/check_button.tscn")
var lazy_menu_enum_packed_scene : PackedScene = preload("res://addons/lazy_menu_2/lazy_settings/elements/enum/enum.tscn")
var lazy_menu_slider_packed_scene : PackedScene = preload("res://addons/lazy_menu_2/lazy_settings/elements/slider/slider.tscn")
var lazy_menu_text_packed_scene : PackedScene = preload("res://addons/lazy_menu_2/lazy_settings/elements/text/text.tscn")

func update_owner(n : Node) -> void:
	
	for c in n.get_children():
		c.owner = n.owner
		c.scene_file_path = ""
		
		update_owner(c)
	

func set_item_name(item : Node, title : String) -> void:
	item.name = title
	var label : Label = item.get_node("Label")
	if label != null:
		label.text = title
		

var build_button : Button
func build() -> void:
	var build_target : LazyMenu = EditorInterface.get_selection().get_selected_nodes()[0]
	
	for c in build_target.get_children():
		c.queue_free()
	
	await get_tree().create_timer(0.01).timeout
	
	if EditorInterface.get_selection().get_selected_nodes()[0] is LazySettingsBuilder:
		
		var lazy_Settings_builder : LazySettingsBuilder = build_target
		
		print("building LazySettings")
		
		var base : Control = lazy_menu_base_packed_scene.instantiate()
		lazy_Settings_builder.add_child(base)
		base.name = "Base"
		
		var elements_area : Control = base.get_node("VBoxContainer/Panel/ScrollContainer/VBoxContainer")
		
		for e : LazySettingsItemBase in lazy_Settings_builder.menu_items:
			var element : LazySettingsElement
			
			if e is LazySettingsItemCheckBox:
				element = load("res://addons/lazy_menu_2/lazy_settings/elements/check_box/check_box.tscn").instantiate()
				set_item_name(element,e.title)
				element.set_meta("base_value",e.base_value)
				element.get_node("VBoxContainer/HBoxContainer/CheckBox").button_pressed = e.base_value
				
			elif e is LazySettingsItemCheckButton:
				element = load("res://addons/lazy_menu_2/lazy_settings/elements/check_button/check_button.tscn").instantiate()
				set_item_name(element,e.title)
				element.set_meta("base_value",e.base_value)
				element.get_node("VBoxContainer/HBoxContainer/CheckButton").button_pressed = e.base_value
				
			elif e is LazySettingsItemEnum:
				element = load("res://addons/lazy_menu_2/lazy_settings/elements/enum/enum.tscn").instantiate()
				set_item_name(element,e.title)
				
				for i in e.items:
					element.get_node("VBoxContainer/OptionButton").add_item(i)
				
				element.set_meta("base_value",e.base_value)
				element.get_node("VBoxContainer/OptionButton").selected = e.base_value
				
			elif e is LazySettingsItemSlider:
				element = load("res://addons/lazy_menu_2/lazy_settings/elements/slider/slider.tscn").instantiate()
				set_item_name(element,e.title)
				element.set_meta("base_value",e.base_value)
				
				element.get_node("VBoxContainer/HSlider").min_value = e.min_value
				element.get_node("VBoxContainer/HSlider").max_value = e.max_value
				element.get_node("VBoxContainer/HSlider").step = e.step_value
				
				element.get_node("VBoxContainer/HSlider").value = e.base_value
				
			elif e is LazySettingsItemText:
				element = load("res://addons/lazy_menu_2/lazy_settings/elements/text/text.tscn").instantiate()
				set_item_name(element,e.title)
				element.set_meta("base_value",e.base_value)
				element.get_node("VBoxContainer/LineEdit").text = e.base_value
			
			if element != null:
				elements_area.add_child(element,true)
			
		
		update_owner(lazy_Settings_builder)
		

func remove_build_button() -> void:
	if build_button.get_parent() != null:
		remove_control_from_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU, build_button)

func update_build_button() -> void:
	if EditorInterface.get_selection().get_selected_nodes().size() > 0:
		
		if EditorInterface.get_selection().get_selected_nodes()[0] is LazySettingsBuilder:
			add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_MENU, build_button)
			
		else:
			remove_build_button()
	else:
		remove_build_button()
	

func _enter_tree() -> void:
	build_button = Button.new()
	build_button.text = "build"
	build_button.icon = load("res://addons/lazy_menu_2/icon.svg")
	build_button.pressed.connect(build)
	
	
	
	EditorInterface.get_selection().selection_changed.connect(update_build_button)


func _exit_tree() -> void:
	
	remove_build_button()
	build_button.queue_free()
