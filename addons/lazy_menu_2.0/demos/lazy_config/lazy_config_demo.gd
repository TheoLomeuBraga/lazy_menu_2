extends Control

func get_current_language_idx() -> int:
	return $LazyConfigBuilder/Base/VBoxContainer/Panel/ScrollContainer/VBoxContainer/language/VBoxContainer/OptionButton.selected

func change_language(idx:int = get_current_language_idx()) -> void:
	match idx:
		0:
			TranslationServer.set_locale("en")
		1:
			TranslationServer.set_locale("pt_BR")



func _ready() -> void:
	$LazyConfigBuilder/Base/VBoxContainer/Panel/ScrollContainer/VBoxContainer/language/VBoxContainer/OptionButton.item_selected.connect(change_language)
	$LazyConfigBuilder/Base/VBoxContainer/HBoxContainer/exit.pressed.connect(get_tree().quit)
	
	
	$LazyConfigBuilder/Base/VBoxContainer/HBoxContainer/default.pressed.connect(change_language)
	change_language()
