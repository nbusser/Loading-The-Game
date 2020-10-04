extends KinematicBody2D

var speed = 1200
var velocity = Vector2()

var alive = true

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	if alive:
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.normal)
			if collision.collider.has_method("hit"):
				collision.collider.hit()
				alive = false
				queue_free()
			else:
				$"ParrySound".play()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
