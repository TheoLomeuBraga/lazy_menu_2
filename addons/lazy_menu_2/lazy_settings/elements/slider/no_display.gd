extends Label



func _process(delta: float) -> void:
	text = str($"../VBoxContainer/HSlider".value)
