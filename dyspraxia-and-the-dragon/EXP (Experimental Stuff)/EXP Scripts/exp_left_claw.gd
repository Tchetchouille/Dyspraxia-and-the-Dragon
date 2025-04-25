extends Node2D

@export var attack_speed = 0.2
signal available

func _on_game_manager_left_claw_attack() -> void:
	var tween = create_tween()
	var initial_pos = position
	# The claw goes to the specified position, and then returns to the intial position
	tween.tween_property(self, "position", Vector2(150, initial_pos.y), 1 / attack_speed)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", initial_pos, 1 / attack_speed)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)
	# When the attack is finished, it sends a signal to the game manager
	await tween.finished
	available.emit()
