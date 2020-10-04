extends "res://Scenes/Enemies/Enemy.gd"

var default_speed = 600
var speed = 0

var velocity = Vector2()

var direction

var pos_loading = 0

var nb_blast_to_go = -1
var nb_shot_to_go = 0

var Bullet = preload("res://Scenes/Enemies/Gun/Bullet.tscn")

func _ready():
	speed = default_speed

func start(pos, _pos_loading, dir):
	#Eyes are buggy...
	#.start(pos, _pos_loading, dir)
	position = pos
	direction = dir
	velocity = Vector2(speed, 0).rotated(direction)
	
	pos_loading = _pos_loading

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var distance = (pos_loading-position).length()
	
	if nb_blast_to_go == 0:
		velocity = Vector2(speed, 0).rotated(direction)
		var collision = move_and_collide(velocity * delta)
	else:
		if distance > 1100:
			velocity = Vector2(speed, 0).rotated(direction)
			var collision = move_and_collide(velocity * delta)
		elif nb_blast_to_go == -1:
			speed = 0
			nb_blast_to_go = randi()%3 + 2
			_on_TimerBlast_timeout()
			

func _on_TimerBlast_timeout():
	nb_blast_to_go -= 1

	if nb_blast_to_go > 0:
		nb_shot_to_go = randi()%3 + 1
		shoot()
		$TimerBullet.wait_time = 0.2
		$TimerBullet.start()
	else:
		direction = -direction
		speed = default_speed

func _on_TimerBullet_timeout():
	nb_shot_to_go -= 1
	if nb_shot_to_go > 0:
		shoot()
		$TimerBullet.wait_time = 0.2
		$TimerBullet.start()
	else:
		$TimerBlast.wait_time = randi()%2 + 0.5
		$TimerBlast.start()

func shoot():
	$Gunshot.play()
	
	var b = Bullet.instance()
	b.start($Gun.position, direction)
	add_child(b)
