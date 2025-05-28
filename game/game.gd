extends Node2D

signal game_over

@onready var player = $Player
@onready var horde_scene = preload("res://game/horde/horde.tscn")
@onready var bullet_scene = preload("res://game/bullet/bullet.tscn")
@onready var power_up_scene = preload("res://game/power_up/power_up.tscn")

@onready var game_over_area = $Area2D
@onready var hud : CenterContainer = $HUD
@onready var score_label : Label = $HUD/HBoxContainer/ScoreLabel
@onready var time_label : Label = $HUD/HBoxContainer/TimeLabel

@onready var game_over_screen : CenterContainer = $GameOverScreen
@onready var game_over_label : Label = $GameOverScreen/VBoxContainer/GameOverLabel
@onready var summary_label : Label = $GameOverScreen/VBoxContainer/SummaryLabel

@onready var horde_spawner : Timer = $HordeSpawner
@onready var power_up_spawner : Timer = $PowerUpSpawner
@onready var speed_boost : Timer = $SpeedBoost

var time_start
var time_now

var is_game_over = false

var score = 0

func _ready() -> void:
	time_start = Time.get_ticks_msec()
	player.connect("spawn_bullet", _spawn_bullet)
	player.position.x = 100
	player.position.y = get_viewport().size.y/2
	
	game_over_area.position = player.position
	var collision_shape : RectangleShape2D = game_over_area.get_child(0).shape
	collision_shape.size.y = get_viewport().size.y
	
	hud.size.x = get_viewport().size.x
	game_over_screen.size = get_viewport().size
	
	_spawn_horde()

func _process(delta: float) -> void:
	if not is_game_over:
		time_now = Time.get_ticks_msec()
		time_label.text = 'Time Alive: '+str((time_now-time_start)/1000)
	
func _spawn_bullet(pos: Vector2) -> void:
	if not is_game_over:
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.global_position = pos

func _on_horde_spawner_timeout() -> void:
	if not is_game_over:
		_spawn_horde()
		if horde_spawner.wait_time > 3:
			horde_spawner.wait_time -= 1

func _on_power_up_spawner_timeout() -> void:
	if not is_game_over:
		_spawn_power_up()

	
func _spawn_horde() -> void:
	var horde = horde_scene.instantiate()
	horde.connect("enemy_destroyed", _on_enemy_destroyed)
	add_child(horde)

func _spawn_power_up() -> void:
	var power_up = power_up_scene.instantiate()
	power_up.connect("power_up_activated", _activate_speed_boost)
	add_child(power_up)
	
func _activate_speed_boost() -> void:
	player.max_speed = 1000.0
	speed_boost.start()

func _deactivate_speed_boost() -> void:
	player.max_speed = 700.0
	
func _on_enemy_destroyed() -> void:
	score += 1
	score_label.text = 'Score: '+str(score)
	
func _on_game_over_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		is_game_over = true
		player.freeze()
		for freezable_node in get_tree().get_nodes_in_group("freezable"):
			freezable_node.freeze()
		_show_game_over_screen()

func _show_game_over_screen() -> void:
	game_over_screen.visible = true
	summary_label.text = 'Score: '+str(score)+'\n'+'Time Alive: '+str((time_now-time_start)/1000)
		
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER and is_game_over:
			game_over.emit()
