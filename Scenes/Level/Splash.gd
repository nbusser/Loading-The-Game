extends Node2D

signal end_splash

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var can_splash = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_PowerButtonSplash_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT  and event.pressed and can_splash:
		$"../PowerButton/ClickSound".play()
		$SplashDelay.start()
		can_splash = false
		
		$"../ArrowHelper".visible = false
		$"../ArrowHelperDelay".stop()
		
func _on_SplashDelay_timeout():
	$SplashSound.play()
	self.visible = true
	$SplashLifetime.start()

func _on_SplashLifetime_timeout():
	self.visible = false
	$"../BlackScreen".visible = false
	$SplashPostmortem.start()
	
func _on_SplashPostmortem_timeout():
	emit_signal("end_splash")
