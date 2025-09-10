extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LazyRebindBuilder.load_binds("lazy_menu_bingings_demo")
	
	$VBoxContainer/HBoxContainer/LazyRebindBuilderKeyboard.update_texts()
	$VBoxContainer/HBoxContainer/LazyRebindBuilderJoystick.update_texts()
	
	$VBoxContainer/HBoxContainer/LazyRebindBuilderKeyboard.exit.connect(get_tree().quit)
	$VBoxContainer/HBoxContainer/LazyRebindBuilderJoystick.exit.connect(get_tree().quit)
	
	
