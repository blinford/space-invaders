extends Node2D

@onready var player = $Player
@onready var bullet_scene = preload("res://game/bullet/bullet.tscn")

func _ready() -> void:
	player.connect("spawn_bullet", _spawn_bullet)
	player.position.x = get_viewport().size.x/2
	player.position.y = get_viewport().size.y - 100

func _spawn_bullet(pos: Vector2) -> void:
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet.global_position = pos
