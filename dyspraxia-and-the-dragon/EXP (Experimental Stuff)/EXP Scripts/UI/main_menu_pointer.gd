extends Control
var target

func _process(delta: float) -> void:
	global_position = global_position.lerp(target, 0.01)

func _on_mode_histoire_focus_entered() -> void:
	target = $"../Title/VBoxContainer/Buttons/HBoxContainer/Mode Histoire".position
	position = position.lerp(target, 1)
