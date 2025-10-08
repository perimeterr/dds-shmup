class_name Enemy extends Area2D

signal killed(points)
signal enemy_bullet_shot(bullet_scene, location)

@export var speed = 150
@export var hp = 1
@export var points = 100
@export var enemy_type = 1

@onready var bullet_spawn  = $BulletSpawn

var enemy_bullet_scene = preload("res://scenes/enemy_bullet.tscn")

func _physics_process(delta):
	global_position.x += -speed * delta

func die():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(1)
		take_damage(1) 

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		killed.emit(points)
		die()

func _on_attack_speed_timeout() -> void:
	enemy_bullet_shot.emit(enemy_bullet_scene, bullet_spawn.global_position)
