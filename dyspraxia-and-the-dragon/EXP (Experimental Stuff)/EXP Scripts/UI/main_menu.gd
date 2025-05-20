extends Control

func _ready() -> void:
	$"../Music".stream = load("res://Assets/Musics/Professor and the Plant.mp3")
	$"../Music".play()	
	
func _on_mode_histoire_pressed() -> void:
	var story_scene = load("res://EXP (Experimental Stuff)/EXP Scenes/UI/story.tscn").instantiate()
	get_tree().root.add_child(story_scene)
	queue_free()


func _on_quitter_pressed() -> void:
	get_tree().quit()


func _on_crédits_pressed() -> void:
	$Credits.visible = true
