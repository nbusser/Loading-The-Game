extends Camera2D

var is_shaking = false
var shake_coef = 1.0

var is_zooming = false
var zoom_obj = Vector2(-1, -1)
var zoom_per_sec = Vector2(-1, -1)

var is_shifting = false
var shift_obj = Vector2(-1, -1)
var shift_per_sec = Vector2(-1, -1)

func shake(coef, duration):
	shake_coef = coef
	is_shaking = true
	$ShakeTimer.wait_time = duration
	$ShakeTimer.start()
	
func zoom(x, y, duration):
	zoom_obj = self.zoom + Vector2(x, y)
	zoom_per_sec = Vector2(x/duration, y/duration)
	is_zooming = true
	
func shift(x, y, duration):
	shift_obj = self.position + Vector2(x, y)
	shift_per_sec = Vector2(x/duration, y/duration)
	is_shifting = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_shaking:
		set_offset(Vector2( \
			rand_range(-1.0, 1.0) * shake_coef, \
			rand_range(-1.0, 1.0) * shake_coef \
		))
		
	if is_zooming:
		zoom += zoom_per_sec*delta
		if abs(self.zoom.x - zoom_obj.x) < 0.1 and abs(self.zoom.y - zoom_obj.y) < 0.1:
			is_zooming = false
			
	if is_shifting:
		position += shift_per_sec*delta
		if abs(position.x - shift_obj.x) < 1 and abs(position.y - shift_obj.y) < 1:
			is_shifting = false

func _on_ShakeTimer_timeout():
	is_shaking = false
	set_offset(Vector2(0,0))
