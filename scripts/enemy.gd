class_name Enemy extends Area2D

@export var speed = 150
@export var hp = 1

func _physics_process(delta):
	global_position.x += -speed * delta

func die():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
		die() 

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		die()
