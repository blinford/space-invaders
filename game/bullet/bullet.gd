extends Area2D

@export var speed = 500

var frozen = false

func _process(delta: float) -> void:
	if not frozen:
		position.x += speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		queue_free()

func freeze() -> void:
	frozen = true
