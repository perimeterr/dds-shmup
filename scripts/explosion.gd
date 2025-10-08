extends Node2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	anim.animation_finished.connect(_on_anim_finished)
	anim.playing = false

func setup_explosion() -> void:
	anim.play("explosion")


func _on_anim_finished(anim_name: String) -> void:
	queue_free()
