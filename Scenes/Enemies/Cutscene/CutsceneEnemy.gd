extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fleeing = false

var time = 0
var destination
var speed
var direction

var freq = 5
var amplitude = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func flee(dest, spd):
	#rotation = (destination-position).angle()
	destination = dest
	speed = spd
	
	fleeing = true

func _physics_process(delta):
	if fleeing:
		var distance = (destination-global_position).length()
		if distance > 100:
			time += delta
			
			#direction = (destination-global_position).angle()
			direction = (destination-global_position).angle()
			var v = Vector2(speed, cos(time*freq)*amplitude).rotated(direction)
			
			move_and_collide(v * delta)
		else:
			fleeing = false
			queue_free()
	
	
