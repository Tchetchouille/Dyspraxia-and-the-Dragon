extends RigidBody2D

@onready var player = $"../ExpCelestiaCharacter"
@onready var dragon = $"../ExpDragon"
@onready var dragon_head = $"../ExpDragon/Head"
@export var fireball_impulse = 1600
var is_reflected = false
var gravity = 1000

# Used to store the gravity scale
# So the fireball can start with no gravity and aim for the player more precisely
var original_gravity_scale

func _ready() -> void:
	original_gravity_scale = gravity_scale
	gravity_scale = 0
	var spawn_point = dragon_head.global_position + Vector2(-50, 0)
	position = spawn_point
	var target = (player.global_position - global_position).normalized()
	apply_impulse(target * fireball_impulse, global_position)

func _physics_process(_delta: float) -> void:
	if is_reflected:
		apply_force(Vector2.DOWN * gravity, Vector2(0, 0))


func _on_body_entered(body: Node) -> void:
	if is_reflected == false:
		is_reflected = true
		set_collision_layer_value(8, true)
