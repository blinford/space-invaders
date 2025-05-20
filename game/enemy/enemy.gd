extends Area2D

var time_start
var time_now

@onready var label = $TimeAliveLabel

func _ready() -> void:
	time_start = Time.get_ticks_msec()
	
func _process(delta: float) -> void:
	time_now = Time.get_ticks_msec()
	if label.text != 'boom!':
		label.text = str((time_now-time_start)/1000)



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		label.text = 'boom!'
		# $AnimatedSprite.play("explosion")
		# $AnimatedSprite.connect("animation_finished", self, "_on_animation_finished")
		queue_free()
	else:
		print(area.get_groups())
