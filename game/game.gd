extends Node2D

@onready var player = $Player
@onready var bullet_scene = preload("res://game/bullet/bullet.tscn")
@onready var enemy_scene = preload("res://game/enemy/enemy.tscn")

var time_start
var time_now

func _ready() -> void:
	time_start = Time.get_ticks_msec()
	player.connect("spawn_bullet", _spawn_bullet)
	player.position.x = get_viewport().size.x/2
	player.position.y = get_viewport().size.y - 100
	_spawn_horde()

func _process(delta: float) -> void:
	time_now = Time.get_ticks_msec()
	# move horde of group "enemies" from top to bottom as well as side to side
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.position.x += 100 * delta * sin((time_now-time_start)/float(1000)) 
		enemy.position.y += 100 * delta
		if enemy.position.y > get_viewport().size.y:
			enemy.queue_free()

func _spawn_bullet(pos: Vector2) -> void:
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet.global_position = pos

func _on_horde_spawner_timeout() -> void:
	_spawn_horde()
	
func _spawn_horde() -> void:
	# spawn horde of enemies centered on random x position within viewport
	var distance_between_enemies = 100
	var number_of_enemies_per_row = 10
	var width = distance_between_enemies * number_of_enemies_per_row
	var random_x = randi_range(width/2, get_viewport().size.x-width)
	var number_of_rows = 3
	for i in range(number_of_rows):
		for j in range(number_of_enemies_per_row):
			var enemy = enemy_scene.instantiate()
			add_child(enemy)
			enemy.position.x = j * distance_between_enemies + random_x
			enemy.position.y = i * distance_between_enemies
