extends Area2D

signal destroyed

var time_start
var time_now

var is_special

var frozen = false

@onready var label = $TimeAliveLabel

func _ready() -> void:
	time_start = Time.get_ticks_msec()
	
func _process(delta: float) -> void:
	if not frozen:
		time_now = Time.get_ticks_msec()
		if label.text != 'boom!':
			label.text = str((time_now-time_start)/1000)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		destroyed.emit()
		$Sprite2D.hide()
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("default")

func freeze() -> void:
	frozen = true

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
