extends AnimatableBody2D

@export var dmg = 10
@export var startup_speed = 1
@export var attack_speed = 1
@export var recovery_speed = 0.8
@export var overshoot_length = 100
signal available

func _on_game_manager_right_claw_attack(target) -> void:
	# Attack phase
	var initial_pos = position
	var overshoot = (position - target).normalized() * -overshoot_length
	var distance = (position - target).length() * 0.001
	# Tween used for the attack
	var attack_tween = create_tween()
	attack(attack_tween, position, target, overshoot, distance, attack_speed, startup_speed)
	# Recovery phase
	await attack_tween.finished
	var recovery_tween = create_tween()
	start_recovery(recovery_tween, initial_pos, distance / recovery_speed)
	# When the attack is finished, it sends a signal to the game manager
	await recovery_tween.finished
	end_recovery()
	available.emit()
	
func attack(pos_tween, a_position, a_target, a_overshoot, a_distance, a_speed, s_speed):
	var rot_tween = create_tween()
	# The claw goes to the specified position, and then returns to the intial position
	pos_tween.tween_property(self, "position", a_position + (a_position - a_target) * 0.1, 1 / s_speed)\
		.set_trans(Tween.TRANS_QUAD)
	pos_tween.tween_property(self, "position", a_target + a_overshoot, a_distance / a_speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN)
	rot_tween.tween_property(self, "rotation", 0.1 * TAU, 1 / s_speed)
	rot_tween.tween_property(self, "rotation", -0.2 * TAU, a_distance / a_speed)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_IN)

func start_recovery(pos_tween, r_position, r_speed):
	var rot_tween = create_tween()
	set_collision_layer_value(9, false)
	set_collision_mask_value(1, false)
	# Tween used for the recovery
	pos_tween.tween_property(self, "position", r_position, r_speed)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_IN)

	rot_tween.tween_property(self, "rotation", 0, r_speed)\
		.set_trans(Tween.TRANS_QUAD)
	
func end_recovery():
	set_collision_layer_value(9, true)
	set_collision_mask_value(1, true)
