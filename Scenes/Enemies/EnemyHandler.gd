extends Node2D

var limit_nb_gun = 3
var limit_nb_enemies = 10

var powerups = [preload("res://Scenes/Powerup/DefensePowerup.tscn"), preload("res://Scenes/Powerup/RepairPowerup.tscn")]

var enemies = [preload("res://Scenes/Enemies/Gun/EnemyGun.tscn"), preload("res://Scenes/Enemies/Sword/EnemySword.tscn")]
var letter_set = ["L", 'D', "4", "7", "o", "a", "d", "i", "n", "g", "N", "O", "T", "p", "u", "s", "h", "w", "e", "r"]

var enemy_wave_index = 0
var preload_wave = []

var can_create = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	pass

func create_enemy(preload_enemy):
	var enemy = preload_enemy.instance()
	
	var letter_text = letter_set[randi() % letter_set.size()]
	enemy.get_node("Label").text = letter_text
	
	var spawn_pos = get_parent().get_position_outside_screen()

	var loading = $"../Loading"
	var dir = (loading.position - spawn_pos).angle()
	enemy.start(spawn_pos, loading.position, dir)
	add_child(enemy)

func begin_create():
	can_create = true
	create_wave()
		
func game_over():
	can_create = false
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.queue_free()
		
	var bullets = get_tree().get_nodes_in_group("bullets")
	for bullet in bullets:
		bullet.queue_free()
	
func create_wave():
	var nb_gun = 0
	
	var nb_enemies_wave = randi()%(limit_nb_enemies-6)+5
	for enemy in range(nb_enemies_wave):
		var chosen_id = randf()
		var enemy_preload
		#Creates gun enemy
		if chosen_id < 0.5 and nb_gun < limit_nb_gun:
			enemy_preload = enemies[0]
			nb_gun += 1
		#Creates sword enemy
		else:
			enemy_preload = enemies[1]
		
		preload_wave.append(enemy_preload)

	#var powerup_spawn_chance = nb_enemies_wave*0.028+0.22

	if randi()%3 != 2:
		spawn_powerup()

	$WaveTimer.wait_time = min(2, nb_enemies_wave)
	
	$EnemyTimer.wait_time = max(randf()-0.35, 0.0)
	$EnemyTimer.start()


func _on_EnemyTimer_timeout():
	create_enemy(preload_wave[enemy_wave_index])
	enemy_wave_index += 1
	
	if enemy_wave_index < preload_wave.size() and can_create:
		$EnemyTimer.wait_time = randf()+1
		$EnemyTimer.start()
	else:
		$WaveTimer.start()

func _on_WaveTimer_timeout():
	if can_create:
		create_wave()

func spawn_powerup():
	var pos = get_parent().get_position_inside_screen()
	
	var chosen_id = randf()
	var powerup_preload
	if chosen_id < 0.5:
		powerup_preload = powerups[0]
	else:
		powerup_preload = powerups[1]
		
	var powerup = powerup_preload.instance()
	powerup.position = pos
	get_parent().add_child(powerup)
