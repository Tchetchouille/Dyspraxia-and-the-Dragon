extends Node2D



func _on_timer_timeout() -> void:
	for child in get_children():
		if child.get_class() == "CPUParticles2D":
			child.restart()
