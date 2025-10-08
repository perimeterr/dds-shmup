class_name Enemy extends Area2D

@export var speed = 150

func _physics_process(delta):
	global_position.x += -speed * delta

func die():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
		die() # Replace with function body.
