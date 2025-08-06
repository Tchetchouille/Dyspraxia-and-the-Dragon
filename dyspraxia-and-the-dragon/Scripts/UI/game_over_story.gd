extends Control

var listening = false

func _process(_delta: float) -> void:
	if Input.is_anything_pressed() and listening:
		var dyspraxia_fight_scene = load("res://Scenes/infinite_mode.tscn").instantiate()
		get_tree().root.add_child(dyspraxia_fight_scene)
		queue_free()


func _on_timer_timeout() -> void:
	listening = true
