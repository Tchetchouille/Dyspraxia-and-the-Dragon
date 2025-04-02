extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var left_stick_input = Input.get_vector("hand_left", "hand_right", "hand_up", "hand_down") * 160
	var right_stick_input = Input.get_vector("sword_left", "sword_right", "sword_up", "sword_down")
	position = left_stick_input
	look_at(global_position + right_stick_input)
	print(right_stick_input)
	
