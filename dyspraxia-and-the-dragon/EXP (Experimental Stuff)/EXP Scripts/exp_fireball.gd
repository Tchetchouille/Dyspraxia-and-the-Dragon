extends RigidBody2D

@onready var player = $"../ExpCelestiaCharacter"
@onready var dragon = $"../ExpDragon/Head"
@onready var timer  = $TimerBeforeDragonThreat
@export var fireball_impulse = 1600
# Used to store the gravity scale
# So the fireball can start with no gravity and aim for the player more precisely
var original_gravity_scale

func _ready() -> void:
	original_gravity_scale = gravity_scale
	gravity_scale = 0
	timer.start()
	var spawn_point = dragon.global_position + Vector2(-50, 0)
	position = spawn_point
	var target = (player.global_position - global_position).normalized()
	apply_impulse(target * fireball_impulse, global_position)



func _on_timer_before_dragon_threat_timeout() -> void:
	set_collision_layer_value(8, true)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
