extends LazySettingsElement
class_name LazySettingsElementText

func _get_value() -> Variant:
	return $VBoxContainer/LineEdit.text

func _set_value(value : Variant) -> void:
	$VBoxContainer/LineEdit.text = value

func _ready() -> void:
	default_value = $VBoxContainer/LineEdit.text
	$VBoxContainer/LineEdit.text_changed.connect(value_changed.emit)
	
	#value_changed.connect(print)
	
