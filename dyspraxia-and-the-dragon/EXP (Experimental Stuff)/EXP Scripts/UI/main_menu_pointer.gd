extends Control
var target

func _process(delta: float) -> void:
	global_position = global_position.lerp(target, 0.01)
