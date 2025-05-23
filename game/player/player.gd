extends Node2D

signal spawn_bullet

var velocity := 0.0
@export var acceleration = 1500.0
@export var deceleration = 1000.0
@export var max_speed = 700.0

@onready var timer = $Timer

var frozen = false

func _process(delta: float) -> void:
	if not frozen:
		# handle movement with acceleration
		if Input.is_action_pressed("left"):
			velocity -= acceleration * delta
		elif Input.is_action_pressed("right"):
			velocity += acceleration * delta
		else:
			if velocity > 0:
				velocity = max(velocity - deceleration * delta, 0)
			elif velocity < 0:
				velocity = min(velocity + deceleration * delta, 0)

		velocity = clamp(velocity, -max_speed, max_speed)
		position.x += velocity * delta
	
		# handle shooting
		if Input.is_action_pressed("shoot"):
			if timer.is_stopped():
				timer.start()
				_spawn_bullet()

func _spawn_bullet() -> void:
	spawn_bullet.emit(global_position)

func freeze() -> void:
	frozen = true
