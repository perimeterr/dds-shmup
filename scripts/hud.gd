extends Control

@onready var score = $Score:
	set(value):
		score.text = "Score: " + str(value)

@onready var health = $Health:
	set(value):
		health.text = "Health: " + str(value)
