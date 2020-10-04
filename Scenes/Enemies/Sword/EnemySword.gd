extends "res://Scenes/Enemies/Enemy.gd"

var speed = 1500
var velocity = Vector2()

var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func start(pos, pos_loading, dir):
	.start(pos, pos_loading, dir)
	direction = dir
	velocity = Vector2(speed, 0).rotated(direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()
			explode()
		else:
			$"ParrySound".play()
			$DefeatSound.playSound()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func explode():
	queue_free()
