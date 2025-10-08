extends CharacterBody2D

signal bullet_shot(bullet_scene, location)

@export var speed = 300

@onready var muzzle = $Muzzle

var bullet_scene = preload("res://scenes/bullet.tscn")

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("left",
	 "right"), Input.get_axis("up","down"))
	velocity = direction * speed
	move_and_slide()

func shoot():
	bullet_shot.emit(bullet_scene, muzzle.global_position)
