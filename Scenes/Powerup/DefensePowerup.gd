extends "res://Scenes/Powerup/Powerup.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_effect():
	$"../Loading/Defense".visible = true
	$"../Loading/Defense/Hitbox".disabled = false
	
func end_effect():
	$"../Loading/Defense".visible = false
	$"../Loading/Defense/Hitbox".disabled = true
