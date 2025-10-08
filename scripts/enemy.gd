class_name Enemy extends Area2D

signal killed(points)
signal enemy_bullet_shot(bullet_scene, location)

@export var speed = 60
@export var wave_amplitude = 50
@export var wave_frequency = 2.0
@export var hp = 1
@export var points = 100
@export var enemy_type = 1

@onready var bullet_spawn  = $BulletSpawn

var enemy_bullet_scene = preload("res://scenes/enemy_bullet.tscn")
var time: float
var center_y: float

func _ready():
	center_y = position.y

func _physics_process(delta):
	if enemy_type == 1:
		time += delta * wave_frequency
		position.x -= delta * speed
		position.y = center_y + sin(time)*wave_amplitude
	else:
		position.x -= delta * speed

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
