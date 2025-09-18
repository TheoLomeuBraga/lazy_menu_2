extends Label

@export var show_only_int : bool = true

func _process(delta: float) -> void:
	if show_only_int:
		text = str(int($"../VBoxContainer/HSlider".value))
	else:
		text = str($"../VBoxContainer/HSlider".value)
