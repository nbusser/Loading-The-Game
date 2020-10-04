extends Area2D

var mouse_over = false
var picked_up = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$PickupLifetime.start()

func start_effect():
	print("Please overwrite start_effect")
	
func end_effect():
	print("Please overwrite end_effect")

func _on_Powerup_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		$PowerupSound.play()
		picked_up = true
		start_effect()
		$Effect.start()
		self.visible = false
		$CollisionShape2D.disabled = true

func _on_Effect_timeout():
	end_effect()
	queue_free()

func _on_PickupLifetime_timeout():
	if not picked_up:
		queue_free()
