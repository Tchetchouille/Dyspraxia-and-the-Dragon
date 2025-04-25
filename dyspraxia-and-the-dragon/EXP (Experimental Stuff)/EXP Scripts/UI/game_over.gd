extends Control

var listening = false

func _process(_delta: float) -> void:
	if Input.is_anything_pressed() and listening:
		get_tree().change_scene_to_file("res://EXP (Experimental Stuff)/EXP Scenes/main.tscn")


func _on_timer_timeout() -> void:
	listening = true
