extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var not_started = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PowerButtonStart_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT  and event.pressed and not_started:
		not_started = false
		$"../PowerButton/ClickSound".play()
		$FaceDelay.start()


func _on_DeathStareTimer_timeout():
	for child in $Words.get_children():
		if child.is_in_group("cutscene_letter"):
			var destination = get_parent().get_node("Screen").get_global_position_outside_screen()
			var speed = randi()%1500+800
			child.flee(destination, speed)
	$FleeTimer.start()


func _on_DeathStareDelay_timeout():
	for child in $Words.get_children():
		if child.is_in_group("cutscene_letter"):
			child.get_node("Face/RightEye/RightPupil").start_stare($"../Screen/Loading".position)
			child.get_node("Face/LeftEye/LeftPupil").start_stare($"../Screen/Loading".position)
	$DeathStareTimer.start()


func _on_FaceDelay_timeout():
	$AlertSound.play()
	$Brouhaha.play()
	for child in $Words.get_children():
		if child.is_in_group("cutscene_letter"):
			child.get_node("Face").visible = true
	$DeathStareDelay.start()
