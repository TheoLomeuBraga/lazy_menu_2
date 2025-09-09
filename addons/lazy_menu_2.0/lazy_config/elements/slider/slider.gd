extends LazyConfigElement
class_name LazyConfigElementSlider

func _get_value() -> Variant:
	return $VBoxContainer/HSlider.value

func _set_value(value : Variant) -> void:
	$VBoxContainer/HSlider.value = value


func _ready() -> void:
	default_value = $VBoxContainer/HSlider.value
	
	$VBoxContainer/HSlider.value_changed.connect(value_changed.emit)
	
	#value_changed.connect(print)
	
