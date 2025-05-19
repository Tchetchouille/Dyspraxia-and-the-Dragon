extends Control
var dyspraxia_combat_preload = preload("res://EXP (Experimental Stuff)/EXP Scenes/dyspraxia_combat.tscn")



func _on_mode_histoire_pressed() -> void:
	var dyspraxia_combat_scene = dyspraxia_combat_preload.instantiate()
	get_tree().root.add_child(dyspraxia_combat_scene)
	queue_free()
