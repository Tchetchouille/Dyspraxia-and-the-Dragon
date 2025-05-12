extends CharacterBody2D

@export var swing_speed = 10
var dyspraxia_speed = 1
var dyspraxia_hand = 0.1
var dyspraxia_blade = 0.1
var dyspraxia = true
var stored_left_input = Vector2(0, 0)
var stored_right_input = Vector2(0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_dyspraxia"):
		dyspraxia = not dyspraxia
	var left_stick_input = Input.get_vector("hand_left", "hand_right", "hand_up", "hand_down") * 160
	var right_stick_input = Input.get_vector("sword_left", "sword_right", "sword_up", "sword_down") * 2000
	if dyspraxia == true:
		if not stored_left_input == left_stick_input:
			dyspraxia_process_hand(left_stick_input, delta)
		dyspraxia_process_blade(right_stick_input, delta)
	else:
		celestia_process(left_stick_input, right_stick_input, delta)
	stored_left_input = left_stick_input
	stored_right_input = right_stick_input
	
func dyspraxia_process_hand(l_input, _delta):
	var new_l_x = l_input.x + l_input.x * randf_range(-dyspraxia_hand, dyspraxia_hand)
	var new_l_y = l_input.y + l_input.y * randf_range(-dyspraxia_hand, dyspraxia_hand)
	l_input = Vector2(new_l_x, new_l_y)
	var tween = create_tween()
	tween.tween_property(self, "position", l_input, 0.2)

func dyspraxia_process_blade(r_input, delta):	
	var new_r_x = r_input.x + r_input.x * randf_range(-dyspraxia_blade, dyspraxia_blade)
	var new_r_y = r_input.y + r_input.y * randf_range(-dyspraxia_blade, dyspraxia_blade)
	r_input = Vector2(new_r_x, new_r_y)
	var new_transform = transform.looking_at(r_input)
	transform = transform.interpolate_with(new_transform, swing_speed * delta * randf() * dyspraxia_speed)

func celestia_process(l_input, r_input, delta):
	var tween = create_tween()
	tween.tween_property(self, "position", l_input, 0.2)
	var new_transform = transform.looking_at(r_input)
	transform = transform.interpolate_with(new_transform, swing_speed * delta)
