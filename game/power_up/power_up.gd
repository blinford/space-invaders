extends Area2D

signal power_up_activated

@export var speed = 100

var frozen = false

func _ready() -> void:
	position = Vector2(get_viewport().size.x / 2, 0)

func _process(delta: float) -> void:
	if not frozen:
		position.y += delta * speed

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		power_up_activated.emit()
		queue_free()
		
func freeze() -> void:
	frozen = true
