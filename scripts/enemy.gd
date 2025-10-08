class_name Enemy extends Area2D

@export var speed = 150
@export var hp = 1
@export var explosion_scene := preload("res://scenes/explosion.tscn")

func _physics_process(delta):
	global_position.x += -speed * delta

func die():
	if explosion_scene:
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position
		get_tree().current_scene.add_child(explosion)
		
		if explosion.has_method("setup_explosion"):
			explosion.setup_explosion()
			
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
