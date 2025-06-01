extends Area2D

signal power_up_activated

@export var speed = 100

var time_start
var time_now

var x_sin_a = 50
var x_sin_w = 1/1000.
var x_sin_k = randf_range(0, 2*3.14)

var spawn_offset = 50

var frozen = false

enum Direction {UP, DOWN}
var direction : Direction

func _ready() -> void:
	time_start = Time.get_ticks_msec()
	direction = randi_range(0, 1)
	if direction == Direction.UP:
		position = Vector2(randi_range(get_viewport().size.x / 2, get_viewport().size.x), get_viewport().size.y+spawn_offset)
	else:
		position = Vector2(randi_range(get_viewport().size.x / 2, get_viewport().size.x), -spawn_offset)

func _process(delta: float) -> void:
	if not frozen:
		time_now = Time.get_ticks_msec()
		position.x += _x_sin(delta)
		if direction == Direction.UP:
			position.y -= delta * speed
			if position.y < -spawn_offset:
				queue_free()
		else:
			position.y += delta * speed
			if position.y > get_viewport().size.y+spawn_offset:
				queue_free()

func _x_sin(delta: float) -> float:
	return delta*x_sin_a*sin(x_sin_w*(time_now-time_start)+x_sin_k)
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		power_up_activated.emit()
		queue_free()
		
func freeze() -> void:
	frozen = true
