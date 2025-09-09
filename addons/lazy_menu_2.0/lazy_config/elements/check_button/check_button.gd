extends LazyConfigElement
class_name LazyConfigElementButton

func _get_value() -> Variant:
	return $VBoxContainer/HBoxContainer/CheckButton.button_pressed

func _set_value(value : Variant) -> void:
	$VBoxContainer/HBoxContainer/CheckButton.button_pressed = value

func _ready() -> void:
	default_value = $VBoxContainer/HBoxContainer/CheckButton.pressed
	$VBoxContainer/HBoxContainer/CheckButton.toggled.connect(value_changed.emit)
	
	#value_changed.connect(print)
	
