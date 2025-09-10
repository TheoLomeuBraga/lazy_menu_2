extends Control

@onready var console : LazyConsoleBuilder = $VBoxContainer/LazyConsoleBuilder

@onready var display_mesh : MeshInstance3D = $VBoxContainer/SubViewportContainer/SubViewport/MeshInstance3D

var rotation_speed : float

func process_cmd(cmd:Array[String]) -> void:
	match cmd[0]:
		"help":
			console.echo("color: change color example: color red")
			console.echo("sphere: change shape to sphere")
			console.echo("cube: change shape to cube")
			console.echo("rspeed: change the rotation speed example: rspeed 1")
			console.echo("quit: close program")
		"clear":
			console.clear()
		"quit":
			get_tree().quit()
		"sphere":
			display_mesh.mesh = SphereMesh.new()
		"cube":
			display_mesh.mesh = BoxMesh.new()
		"rspeed":
			rotation_speed = cmd[1].to_float()
			console.echo("rotaton speed set to: " + cmd[1])
		"color":
			match cmd[1]:
				"help":
					console.echo("colors avaliable:")
					console.echo("	red")
					console.echo("	green")
					console.echo("	blue")
				"red":
					display_mesh.material_override.albedo_color = Color.RED
					console.echo("color set to: [color=red][wave]RED[/wave][/color]")
				"green":
					display_mesh.material_override.albedo_color = Color.GREEN
					console.echo("color set to: [color=green][wave]GREEN[/wave][/color]")
				"blue":
					display_mesh.material_override.albedo_color = Color.BLUE
					console.echo("color set to: [color=blue][wave]BLUE[/wave][/color]")

func _ready() -> void:
	console.cmd_submitted.connect(process_cmd)

func _process(delta: float) -> void:
	display_mesh.rotation.y += delta * rotation_speed
