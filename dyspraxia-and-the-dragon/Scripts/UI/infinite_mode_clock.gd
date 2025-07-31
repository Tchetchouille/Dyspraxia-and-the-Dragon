extends RichTextLabel

var total_time = 0
@onready var gm = 	$"../../GameManager"

func _on_timer_timeout() -> void:
	total_time += 1
	var m = int(total_time / 60.0)
	var s = total_time - m * 60
	text = "[center]%02d:%02d[/center]" % [m, s]
	if gm.down_fireball_threshold < 100:
		gm.down_fireball_threshold += round(s / 10.0)
	if gm.up_fireball_threshold < 50:
		gm.up_fireball_threshold += round(s / 10.0)
