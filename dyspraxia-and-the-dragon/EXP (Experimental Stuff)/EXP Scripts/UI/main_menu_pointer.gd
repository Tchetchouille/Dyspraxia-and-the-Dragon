extends Control
var target

func _on_mode_histoire_focus_entered() -> void:
	target = $"../Title/VBoxContainer/Buttons/HBoxContainer/Mode Histoire".position
	position = position.lerp(target, 1)


func _on_mode_histoire_mouse_entered() -> void:
	target = $"../Title/VBoxContainer/Buttons/HBoxContainer/Mode Histoire".global_position
	position = position.lerp(target, 0.1)
