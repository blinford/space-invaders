extends Node2D

@onready var player = $Player
@onready var bullet_scene = preload("res://game/bullet/bullet.tscn")

func _ready() -> void:
	yield(self, "start_game")
	player.connect("spawn_bullet", _spawn_bullet)

func _spawn_bullet(pos: Vector2) -> void:
	var bullet = bullet_scene.instantiate()
	bullet.position = pos
	add_child(bullet)
