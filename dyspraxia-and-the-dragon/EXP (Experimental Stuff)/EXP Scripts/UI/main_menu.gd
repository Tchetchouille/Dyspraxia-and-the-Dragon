extends Control
	
func _on_mode_histoire_pressed() -> void:
	var story_scene = load("res://EXP (Experimental Stuff)/EXP Scenes/UI/story.tscn").instantiate()
	get_tree().root.add_child(story_scene)
	queue_free()


func _on_quitter_pressed() -> void:
	get_tree().quit()


func _on_crédits_pressed() -> void:
	var credit_scene = load("res://EXP (Experimental Stuff)/EXP Scenes/UI/credits.tscn").instantiate()
	get_tree().root.add_child(credit_scene)
	queue_free()
