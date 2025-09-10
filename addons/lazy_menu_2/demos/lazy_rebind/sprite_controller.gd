extends Sprite2D

@export var speed : float = 500.0

func _process(delta: float) -> void:
	position += Input.get_vector("left","right","up","down") * speed * delta
	position.x = int(position.x) % DisplayServer.window_get_size().x
	position.y = int(position.y) % (DisplayServer.window_get_size().y / 2)
	
	if position.x < 0:
		position.x = DisplayServer.window_get_size().x
	
	if position.y < 0:
		position.y = DisplayServer.window_get_size().y / 2
