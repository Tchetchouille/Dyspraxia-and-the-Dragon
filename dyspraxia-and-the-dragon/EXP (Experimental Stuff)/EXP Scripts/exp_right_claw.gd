extends Node2D

@export var attack_speed = 3
var active = 0

func _on_game_manager_right_claw_attack() -> void:
	active = 1

func _physics_process(_delta: float) -> void:
	# $Body.move_and_collide(Vector2(-attack_speed * active, 0))
	pass
