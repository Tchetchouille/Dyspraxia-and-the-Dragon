extends Node2D
var alpha = 1
var fade_speed = 1.2
var outline_color = Color(0, 0, 0, 1)
var font_color = Color(0.8, 0.2, 0.1, 1)
var frame_count = 0
var base_x = 0

func _ready() -> void:
	base_x = position.x

func _on_before_fade_timer_timeout() -> void:
	$FadeTimer.start()

func _on_fade_timer_timeout() -> void:
	if alpha >= 0:
		alpha = alpha / fade_speed
	set("modulate", Color(1, 1, 1, alpha))

func _on_destroy_timer_timeout() -> void:
	queue_free()

func _process(delta: float) -> void:
	frame_count += 1
	position.x = base_x + cos(frame_count / 5.0) * frame_count / 2
	position.y = position.y - (frame_count / 10) ** 1.1
	get_child(0).set("theme_override_colors/default_color", font_color)
	get_child(0).set("theme_override_colors/font_outline_color", outline_color)
