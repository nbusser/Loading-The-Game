extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var max_hp = 10
var hp = max_hp

var need_help = true

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func heal(ammount):
	hp += ammount
	hp = min(max_hp, hp)
	for impact in get_tree().get_nodes_in_group("impact"):
		impact.queue_free()
		break

func _on_Loading_on_hit():
	hp -= 1
	
	if (max_hp-hp)%3 == 0:
		$Screen.generate_impact()
		
	if hp == 0:
		game_over()
	else:
		$Camera2D.shake(30.0, 0.3)

	
func game_over():
	$Music.stop()
	$Camera2D.shake(100.0, ($BSOD_pop_timer.wait_time-1)/2)
	$Screen/EnemyHandler.game_over()
	$Screen/Loading.game_over()
	$BlackScreen.visible = true
	
	$BSOD_pop_timer.start()

func _on_Splash_end_splash():
	$Music.play()
	$PowerButton/PowerButtonSplash.visible = false
	$PowerButton/PowerButtonStart.visible = true
	
	$Camera2D.zoom(-2, -2, 1)
	$Camera2D.shift(0, -500, 1)

func _on_FleeTimer_timeout():
	# Game begins
	$Screen/Loading.give_control()
	$Screen/EnemyHandler.begin_create()


func _on_Cheat_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT  and event.pressed:
		_on_FleeTimer_timeout()

func _on_BSOD_pop_timer_timeout():
	$BSOD/BsodSound.play()
	$BSOD.visible = true
	
func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _on_Loading_win():
	$Screen/EnemyHandler.game_over()
	$WinScreen.visible = true


func _on_ArrowHelperDelay_timeout():
	$ArrowHelper.visible = true
	
