extends Node2D

signal enemy_destroyed

@onready var enemy_scene = preload("res://game/horde/enemy/enemy.tscn")

var time_start
var time_now

func _ready() -> void:
	time_start = Time.get_ticks_msec()
	
	var distance_between_enemies = 100
	var number_of_enemies_per_row = 10
	var width = distance_between_enemies * number_of_enemies_per_row
	var random_x = randi_range(width/2, get_viewport().size.x-width)
	var number_of_rows = 1
	for i in range(number_of_rows):
		for j in range(number_of_enemies_per_row):
			var enemy = enemy_scene.instantiate()
			enemy.connect("destroyed", _on_enemy_destroyed)
			add_child(enemy)
			enemy.position.x = j * distance_between_enemies + random_x
			enemy.position.y = i * distance_between_enemies

func _process(delta: float) -> void:
	time_now = Time.get_ticks_msec()
	
	for enemy in get_children():
		enemy.position.x += 100 * delta * sin((time_now-time_start)/float(1000)) 
		enemy.position.y += 100 * delta + 0.5 * sin((time_now-time_start+100)/float(1000))

func _on_enemy_destroyed() -> void:
	enemy_destroyed.emit()
