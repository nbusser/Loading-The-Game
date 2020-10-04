extends "res://Scenes/Powerup/Powerup.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_effect():
	$"../../../Level".heal(3)
	
func end_effect():
	pass
