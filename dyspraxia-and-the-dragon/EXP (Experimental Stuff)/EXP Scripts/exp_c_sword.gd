extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var pos = Input.get_vector("hand_left", "hand_right", "hand_up", "hand_down") * 160
	var tween = create_tween()
	tween.tween_property(self, "position", pos, 0.2)
