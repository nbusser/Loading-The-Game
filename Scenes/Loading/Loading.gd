extends Node2D

signal on_hit
signal win

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var autorun = true
var controlable = false
var cutscene_rotation_speed = 1

var objective = 700
var score_penalty = -1

var sound_level = 0

func _ready():
	pass # Replace with function body.

func get_score():
	if score_penalty == -1:
		return 0
		
	return rotation-score_penalty

func give_control():
	$LoadingSound.play()
	autorun = false
	controlable = true
	score_penalty = rotation

func game_over():
	autorun = false
	controlable = false

func _process(delta):
	if not controlable and autorun:
		self.rotate(cutscene_rotation_speed*delta)
		if cutscene_rotation_speed < 5:
			cutscene_rotation_speed += 0.5*delta
	else:
		var mouse_position = get_local_mouse_position()
		var head_position = self.get_node("Head").position
		
		var angle = head_position.angle_to(mouse_position)
		
		if angle > 0:
			var rotation_angle = 6*angle*angle
			self.rotate(rotation_angle*delta)
		
		#Sound level update
		var sound_modifier
		if angle < 0.5:
			sound_modifier = -0.2
		else:
			sound_modifier = angle/20

		sound_level += sound_modifier
		sound_level = min(sound_level, -3)
		sound_level = max(sound_level, -40)
		$LoadingSound.volume_db = sound_level
		
		if sound_level < -20:
			$LoadingSound.play()

	$"../ProgressBar".value = get_score()*100/objective

	if get_score() > objective:
		emit_signal("win")

func _on_Body_on_hit():
	$HitSound.play()
	emit_signal("on_hit")
