extends KinematicBody2D

var pos_loading
var staring = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_stare(_pos_loading):
	pos_loading = _pos_loading
	staring = true

func _physics_process(delta):
	if staring:
		var direction = (pos_loading-position).angle()
		var velocity = Vector2(10, 0).rotated(direction)
		move_and_collide(velocity * delta)
