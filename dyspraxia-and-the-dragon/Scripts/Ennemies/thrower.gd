extends Node2D

var frame_count = 0

func _process(delta: float) -> void:
	frame_count += 1
	var target_x = position.x + cos(frame_count / 40.0) * 10
	var target_y = position.y + remap(abs(sin(frame_count / 40.0)),0, 1, 0.5, 1) * 10
	look_at(Vector2(target_x, target_y))
