extends Area2D

@export var speed = 500

func _process(delta: float) -> void:
	position.y -= speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		queue_free()
	else:
		print(area.get_groups())
