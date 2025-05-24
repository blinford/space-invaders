extends Area2D

signal destroyed

var time_start
var time_now

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
		# $AnimatedSprite.play("explosion")
		# $AnimatedSprite.connect("animation_finished", self, "_on_animation_finished")
		queue_free()

func freeze() -> void:
	frozen = true
