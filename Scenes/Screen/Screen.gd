extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var impacts_textures = [preload("res://Scenes/Screen/impact.png"), preload("res://Scenes/Screen/impact2.png"), preload("res://Scenes/Screen/impact3.png")]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_position_outside_screen():
	var offset_x = int($ScreenSprite.texture.get_size().x*0.5)
	var size_x = int($ScreenSprite.texture.get_size().x)
	
	var offset_y = int($ScreenSprite.texture.get_size().y*0.5)
	var size_y = int($ScreenSprite.texture.get_size().y)
	
	var pos_x
	var pos_y
	
	var lock_x = randf()
	if lock_x > 0.5:
		var inf = randf()
		if inf > 0.5:
			pos_x = -randi()%offset_x
		else:
			pos_x = randi()%offset_x+size_x
		
		pos_y = randi()%(size_y+2*offset_y)-offset_y
	else:
		var inf = randf()
		if inf > 0.5:
			pos_y = -randi()%offset_y
		else:
			pos_y = randi()%offset_y+size_y
		
		pos_x = randi()%(size_x+2*offset_x)-offset_x

	return Vector2(pos_x, pos_y)

func get_global_position_outside_screen():
	return get_position_outside_screen()+position
	
func get_position_inside_screen():
	var max_x = int($ScreenSprite.texture.get_size().x)
	var max_y = int($ScreenSprite.texture.get_size().y)
	
	return Vector2(randi()%max_x, randi()%max_y)

func get_global_position_inside_screen():
	return get_position_inside_screen()+position

func generate_impact():
	$GlassSound.play()
	
	var pos_x = randi()%int($ScreenSprite.texture.get_size().x)
	var pos_y = randi()%int($ScreenSprite.texture.get_size().y)
	
	var sprite = Sprite.new()
	sprite.texture = impacts_textures[randi()%impacts_textures.size()]
	sprite.position = Vector2(pos_x, pos_y)
	sprite.z_index = 2
	sprite.z_as_relative = false
	sprite.add_to_group("impact")
	add_child(sprite)
