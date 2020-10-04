extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String) var word
export(float) var scaling = 1.0

var Letter = preload("res://Scenes/Enemies/Cutscene/CutsceneEnemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var letter_pos = Vector2(position.x, position.y)
	
	for c in word:
		if c != " ":
			var letter = Letter.instance()
			letter.get_node("Label").text = c
			letter.position = letter_pos
			letter.scale = Vector2(scaling, scaling)
			get_parent().call_deferred("add_child",letter)
			letter.add_to_group("cutscene_letter")
		letter_pos.x += 85*scaling

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
