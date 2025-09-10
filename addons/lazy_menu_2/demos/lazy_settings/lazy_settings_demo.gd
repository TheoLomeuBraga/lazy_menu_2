extends Control

func get_current_language_idx() -> int:
	return $LazySettingsBuilder/Base/VBoxContainer/Panel/ScrollContainer/VBoxContainer/language/VBoxContainer/OptionButton.selected

func change_language(idx:int = get_current_language_idx()) -> void:
	match idx:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("pt_BR")



func _ready() -> void:
	$LazySettingsBuilder/Base/VBoxContainer/Panel/ScrollContainer/VBoxContainer/language/VBoxContainer/OptionButton.item_selected.connect(change_language)
	$LazySettingsBuilder/Base/VBoxContainer/HBoxContainer/exit.pressed.connect(get_tree().quit)
	
	
	$LazySettingsBuilder/Base/VBoxContainer/HBoxContainer/default.pressed.connect(change_language)
	change_language()
	
	var data_dictionary : Dictionary = LazySettingsBuilder.load_data_dictionary("lazy_menu_demo_config")
	for k in data_dictionary:
		print(k," : ",data_dictionary[k])
