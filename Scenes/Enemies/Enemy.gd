extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(pos, pos_loading, dir):
	position = pos
	$Face/LeftEye/LeftPupil.start_stare(pos_loading)
	$Face/RightEye/RightPupil.start_stare(pos_loading)
	
	if randf() > 0.5:
		$Voice.playSound()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
