extends LazyConfigElement
class_name LazyConfigElementCheckBox

func _get_value() -> Variant:
	return $VBoxContainer/HBoxContainer/CheckBox.button_pressed

func _set_value(value : Variant) -> void:
	$VBoxContainer/HBoxContainer/CheckBox.button_pressed = value

func _ready() -> void:
	default_value = $VBoxContainer/HBoxContainer/CheckBox.button_pressed
	$VBoxContainer/HBoxContainer/CheckBox.toggled.connect(value_changed.emit)
	
	#value_changed.connect(print)
	
