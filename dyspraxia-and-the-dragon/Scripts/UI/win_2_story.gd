extends Control

var listening = false

func _process(_delta: float) -> void:
	if Input.is_anything_pressed() and listening:
		$"../Main".global_dyspraxia = true
		var story_scene = load("res://Scenes/UI/story3.tscn").instantiate()
		get_tree().root.add_child(story_scene)
		queue_free()


func _on_timer_timeout() -> void:
	listening = true
