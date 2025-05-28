extends Node2D

signal enemy_destroyed

@onready var enemy_scene = preload("res://game/horde/enemy/enemy.tscn")

var time_start
var time_now

var frozen = false

var x_speed = 100.

# a*sin(w*x+k)
var x_sin_a = 50
var x_sin_w = 1/1000.
var x_sin_k = randf_range(0, 2*3.14)
var y_sin_a = 100
var y_sin_w = 1/1000.
var y_sin_k = randf_range(0, 2*3.14)

func _ready() -> void:
	time_start = Time.get_ticks_msec()
	
	var distance_between_enemies = 100
	var number_of_enemies_per_row = 10
	var width = distance_between_enemies * number_of_enemies_per_row
	var random_y = randi_range(y_sin_a*2, get_viewport().size.y-width-y_sin_a)
	var number_of_rows = 1
	for i in range(number_of_rows):
		for j in range(number_of_enemies_per_row):
			var enemy = enemy_scene.instantiate()
			enemy.connect("destroyed", _on_enemy_destroyed)
			add_child(enemy)
			enemy.position.x = get_viewport().size.x - (i * distance_between_enemies)
			enemy.position.y = j * distance_between_enemies + random_y

func _process(delta: float) -> void:
	if not frozen:
		time_now = Time.get_ticks_msec()
		
		for enemy in get_children():
			enemy.position.x -= delta * x_speed + _x_sin(delta)
			enemy.position.y += _y_sin(delta)

func _x_sin(delta: float) -> float:
	return delta*x_sin_a*sin(x_sin_w*(time_now-time_start)+x_sin_k)
	
func _y_sin(delta: float) -> float:
	return delta*y_sin_a*sin(y_sin_w*(time_now-time_start)+y_sin_k)

func _on_enemy_destroyed() -> void:
	enemy_destroyed.emit()
	
func freeze() -> void:
	frozen = true
