extends LazyConfigElement
class_name LazyConfigElementEnum

func _get_value() -> Variant:
	return $VBoxContainer/OptionButton.selected

func _set_value(value : Variant) -> void:
	$VBoxContainer/OptionButton.select(value)

@export var itens : Array[String]

func _ready() -> void:
	default_value = $VBoxContainer/OptionButton.selected
	$VBoxContainer/OptionButton.item_selected.connect(value_changed.emit)
	
	#value_changed.connect(print)
	
