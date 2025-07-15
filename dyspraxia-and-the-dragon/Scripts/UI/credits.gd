extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_anything_pressed() and is_visible_in_tree():
		var main_menu_scene = load("res://Scenes/UI/main_menu.tscn").instantiate()
		get_tree().root.add_child(main_menu_scene)
		queue_free()
