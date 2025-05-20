extends Node2D

@onready var menu = $Menu
@onready var game_scene : PackedScene = preload("res://game/game.tscn")

var game = null

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_accept") and game == null:
		_start_game()
		
func _start_game() -> void:
	menu.hide()
	game = game_scene.instantiate()
	add_child(game)
