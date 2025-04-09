extends RigidBody2D

@onready var player = $"../ExpCelestiaCharacter"
@onready var dragon = $"../ExpDragon/Head"
@export var fireball_impulse = 1000

func _ready() -> void:
	var spawn_point = dragon.global_position + Vector2(-50, 0)
	position = spawn_point
	var target = (player.global_position - global_position + Vector2(0, -300)).normalized()
	apply_impulse(target * fireball_impulse, global_position)
