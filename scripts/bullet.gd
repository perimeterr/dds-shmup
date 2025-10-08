extends Area2D

@export var speed = 600
@export var damage = 1

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	animated_sprite.animation = "default"

func _physics_process(delta):
	global_position.x += speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Enemy:
		area.take_damage(damage)
		animated_sprite.animation = "explosion"
		var tween = create_tween()
		tween.tween_property(animated_sprite, "scale", Vector2(3,3), 0.05)
		await tween.finished
		queue_free()
