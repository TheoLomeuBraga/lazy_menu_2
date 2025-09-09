extends LazyConfig
class_name LazyConfigElement



signal value_changed(value : Variant)

var default_value : Variant = null

func _get_value() -> Variant:
	return null

func _set_value(value : Variant) -> void:
	pass

func reset_to_default() -> void:
	_set_value(default_value)
