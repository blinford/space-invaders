extends Node2D

signal game_over

@onready var player = $Player
@onready var bullet_scene = preload("res://game/bullet/bullet.tscn")
@onready var enemy_scene = preload("res://game/enemy/enemy.tscn")
@onready var game_over_area = $Area2D
@onready var hud : CenterContainer = $HUD
@onready var label : Label = $HUD/Label

var time_start
var time_now

var is_game_over = false

var score = 0

func _ready() -> void:
	time_start = Time.get_ticks_msec()
	player.connect("spawn_bullet", _spawn_bullet)
	player.position.x = get_viewport().size.x/2
	player.position.y = get_viewport().size.y - 100
	
	game_over_area.position = player.position
	var collision_shape : RectangleShape2D = game_over_area.get_child(0).shape
	collision_shape.size.x = get_viewport().size.x
	
	hud.size.x = get_viewport().size.x
	
	_spawn_horde()

func _process(delta: float) -> void:
	if not is_game_over:
		time_now = Time.get_ticks_msec()
		# move horde of group "enemies" from top to bottom as well as side to side
		var enemies = get_tree().get_nodes_in_group("enemies")
		for enemy in enemies:
			enemy.position.x += 100 * delta * sin((time_now-time_start)/float(1000)) 
			enemy.position.y += 100 * delta

func _spawn_bullet(pos: Vector2) -> void:
	if not is_game_over:
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.global_position = pos

func _on_horde_spawner_timeout() -> void:
	if not is_game_over:
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
			enemy.connect("destroyed", _on_enemy_destroyed)
			add_child(enemy)
			enemy.position.x = j * distance_between_enemies + random_x
			enemy.position.y = i * distance_between_enemies

func _on_enemy_destroyed() -> void:
	score += 1
	label.text = str(score)
	
func _on_game_over_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		is_game_over = true
		player.freeze()
		for enemy in get_tree().get_nodes_in_group("enemies"):
			enemy.freeze()
		for bullet in get_tree().get_nodes_in_group("bullets"):
			bullet.freeze()
		await get_tree().create_timer(1).timeout
		game_over.emit()
