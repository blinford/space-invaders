extends Node2D

signal spawn_bullet

@export var speed := 400.0

@onready var timer = $Timer

func _process(delta: float) -> void:
	# handle movement
	var dir = 0.0
	if Input.is_action_pressed("left"):
		dir -= 1.0
	if Input.is_action_pressed("right"):
		dir += 1.0
	position.x += dir * delta * speed
	
	# handle shooting
	if Input.is_action_pressed("shoot"):
		if timer.is_stopped():
			timer.start()
			_spawn_bullet()

func _spawn_bullet() -> void:
	spawn_bullet.emit(global_position)
