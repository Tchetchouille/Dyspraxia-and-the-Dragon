extends Control

var listening = false

func _process(_delta: float) -> void:
	if Input.is_anything_pressed() and listening:
		$"../Main".global_dyspraxia = false
		var celestia_fight_scene = load("res://EXP (Experimental Stuff)/EXP Scenes/UI/main_menu.tscn").instantiate()
		get_tree().root.add_child(celestia_fight_scene)
		queue_free()


func _on_timer_timeout() -> void:
	listening = true
