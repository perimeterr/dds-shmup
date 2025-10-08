extends Node2D

@export var enemy_scenes: Array[PackedScene] = []

@onready var player_spawn_pos = $PlayerSpawnPos
@onready var bullet_container = $BulletContainer
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var hud = $UILayer/HUD

var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score
var health := 5:
	set(value):
		health = value
		hud.health = health

func _ready():
	score = 0
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position
	player.bullet_shot.connect(_on_player_bullet_shot)
	

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
	if timer.wait_time > 0.4:
		timer.wait_time -= delta*0.005
	elif timer.wait_time < 0.4:
		timer.wait_time = 0.4
		
	for e in enemy_container.get_children():
		if !e.enemy_bullet_shot.is_connected(_on_player_bullet_shot):
			if e.enemy_type == 1:
				e.enemy_bullet_shot.connect(_on_player_bullet_shot)
	
	if player != null:
		health = player.hp
	else:
		health = 0
		
	

func _on_player_bullet_shot(bullet_scene, location):
	var bullet = bullet_scene.instantiate()
	bullet.global_position = location 
	bullet_container.add_child(bullet)

func _on_enemy_spawn_timer_timeout() -> void:
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(1158,1258),randf_range(140,500))
	e.killed.connect(_on_enemy_killed)
	enemy_container.add_child(e)

func _on_enemy_killed(points):
	score += points
	print(score)
