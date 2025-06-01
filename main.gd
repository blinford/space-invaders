extends Node2D

@onready var menu = $Menu
@onready var game_scene : PackedScene = preload("res://game/game.tscn")
@onready var save = $Save

var game = null

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("enter") and game == null:
		_start_game()
		
func _start_game() -> void:
	menu.hide()
	game = game_scene.instantiate()
	game.connect("game_over", _on_game_over)
	add_child(game)

func _on_game_over() -> void:
	menu.show()
	save.save_score(game.score)
	game.queue_free()
