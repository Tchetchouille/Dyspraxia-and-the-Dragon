extends Control
	

func _ready() -> void:
	if $"../Music" != null:
		$"../Music".stream = load("res://Assets/Musics/Professor and the Plant.mp3")
		$"../Music".play()
	elif $"../Main/Music" != null:
		$"../Main/Music".stream = load("res://Assets/Musics/Professor and the Plant.mp3")
		$"../Main/Music".play()

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


func _on_mode_infini_pressed() -> void:
	var credit_scene = load("res://EXP (Experimental Stuff)/EXP Scenes/infinite_mode.tscn").instantiate()
	get_tree().root.add_child(credit_scene)
	queue_free()
