extends CharacterBody2D

@export var swing_speed = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var left_stick_input = Input.get_vector("hand_left", "hand_right", "hand_up", "hand_down") * 160
	var right_stick_input = Input.get_vector("sword_left", "sword_right", "sword_up", "sword_down") * 2000
	var tween = create_tween()
	tween.tween_property(self, "position", left_stick_input, 0.2)
	# look_at(global_position + right_stick_input)
	var new_transform = transform.looking_at(right_stick_input)
	transform = transform.interpolate_with(new_transform, swing_speed * delta)
