extends Node2D

@export var scroll_speed := 100
@onready var bg1 = $Background1
@onready var bg2 = $Background2

func _process(delta):
	bg1.position.x -= scroll_speed * delta
	bg2.position.x -= scroll_speed * delta

	var tex_width = bg1.texture.get_width()

	if bg1.position.x <= -tex_width:
		bg1.position.x = bg2.position.x + tex_width

	if bg2.position.x <= -tex_width:
		bg2.position.x = bg1.position.x + tex_width
