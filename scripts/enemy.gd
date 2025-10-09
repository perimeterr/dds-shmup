class_name Enemy extends CharacterBody2D

signal killed(points)
signal enemy_bullet_shot(bullet_scene, location)

@export var speed = 60
@export var wave_amplitude = 50
@export var wave_frequency = 2.0
@export var hp = 1
@export var points = 100
@export var enemy_type = 1
@export var attack_speed = 1

@onready var bullet_spawn  = $BulletSpawn
@onready var animated_sprite = $AnimatedSprite2D
@onready var area2d = $Area2D
@onready var laser = $Laser
@onready var attack_speed_timer = $AttackSpeedTimer

var enemy_bullet_scene = preload("res://scenes/enemy_bullet.tscn")
var time: float
var center_y: float
var is_colliding_with_player = false

func _ready():
	center_y = position.y
	attack_speed_timer.wait_time = attack_speed
	if enemy_type != 3:
		laser.queue_free()
	
func _physics_process(delta):
	time += delta * wave_frequency
	position.x -= delta * speed
	position.y = center_y + sin(time)*wave_amplitude

func die():
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		animated_sprite.animation = "explosion"
		var tween = create_tween()
		tween.tween_property(animated_sprite, "scale", Vector2(1,1), 0.1)
		await tween.finished
		killed.emit(points)
		die()

func _on_attack_speed_timeout() -> void:
	if enemy_type == 3:
		laser_attack()
	else:
		enemy_bullet_shot.emit(enemy_bullet_scene, bullet_spawn.global_position)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.collide()
		body.take_damage(1)
		take_damage(1) 
		
func laser_attack():
	laser.is_casting = true
	await get_tree().create_timer(2).timeout
	laser.is_casting = false
