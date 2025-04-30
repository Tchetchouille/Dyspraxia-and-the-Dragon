extends RigidBody2D

@export var dmg = 5
@onready var player = $"../CelestiaCharacter"
@onready var dragon = $"../Dragon"
@onready var dragon_head = $"../Dragon/Head"
@export var fireball_impulse = 1600
var gravity = 1000
var target_offset = 0.1
var impulse_offset = 200
var is_reflected = false

# Used to store the gravity scale
# So the fireball can start with no gravity and aim for the player more precisely
var original_gravity_scale

func _ready() -> void:
	original_gravity_scale = gravity_scale
	gravity_scale = 0
	var spawn_point = dragon_head.global_position + Vector2(-50, 0)
	position = spawn_point
	var x_offset = randf_range(-target_offset,target_offset)
	var y_offset = randf_range(-target_offset,target_offset)
	var x_y_offset = Vector2(x_offset, y_offset)
	var i_offset = randi_range(-impulse_offset, impulse_offset)
	var target = (player.global_position - global_position).normalized()
	apply_impulse((target + x_y_offset) * (fireball_impulse + i_offset), global_position)

func _physics_process(_delta: float) -> void:
	if is_reflected:
		apply_force(Vector2.DOWN * gravity, Vector2(0, 0))


func _on_body_entered(_body: Node) -> void:
	if is_reflected == false:
		is_reflected = true
		set_collision_layer_value(8, true)
