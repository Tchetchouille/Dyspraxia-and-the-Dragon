extends RigidBody2D
class_name UpFireball

var size = Vector2(2, 2)
var dmg = 10
@onready var player = $"../CelestiaCharacter"
@onready var fireball_spawn = $"../Dragon/UpFireballSpawn"
@onready var particles = preload("res://EXP (Experimental Stuff)/EXP Scenes/Ennemies/particles_system.tscn")
@onready var yellow_sprite = $YSprite
@onready var orange_sprite = $OSprite
@onready var red_sprite = $RSprite
@onready var yellow_sprites = [
	preload("res://Assets/Fireball Pictures/y1.png"),
	preload("res://Assets/Fireball Pictures/y2.png"),
	preload("res://Assets/Fireball Pictures/y3.png"),
	preload("res://Assets/Fireball Pictures/y4.png")
]
@onready var orange_sprites = [
	preload("res://Assets/Fireball Pictures/o1.png"),
	preload("res://Assets/Fireball Pictures/o2.png"),
	preload("res://Assets/Fireball Pictures/o3.png"),
	preload("res://Assets/Fireball Pictures/o4.png")
]
@onready var red_sprites = [
	preload("res://Assets/Fireball Pictures/r1.png"),
	preload("res://Assets/Fireball Pictures/r2.png"),
	preload("res://Assets/Fireball Pictures/r3.png"),
	preload("res://Assets/Fireball Pictures/r4.png")
]
var y_index = 0
var o_index = 0
var r_index = 0

@export var fireball_impulse = 300
var gravity = 300
var target_offset = 0.1
var impulse_offset = 200
var is_reflected = false
# Used to store the gravity scale
# So the fireball can start with no gravity and aim for the player more precisely
var original_gravity_scale
var frame_count = 0

func _ready() -> void:
	original_gravity_scale = gravity_scale
	gravity_scale = 0
	var spawn_point = fireball_spawn.global_position
	position = spawn_point
	apply_impulse(Vector2(-130, -fireball_impulse))
	scale = size

func _physics_process(_delta: float) -> void:
	scale = size
	$CollisionShape2D.scale = size
	if is_reflected:
		apply_force(Vector2.DOWN * gravity, Vector2(0, 0))
	look_at(global_position - linear_velocity)
	_flicker(frame_count, 9, 3)
	frame_count += 1

func _on_body_entered(_body: Node) -> void:
	if is_reflected == false:
		is_reflected = true
		set_collision_layer_value(8, true)
		_emit_particles()

func _flicker(t, start, delay):
	modulate = Color(2, 2, 1)
	if t % start == 0:
		var y_indexes = range(yellow_sprites.size())
		y_indexes.remove_at(y_index)
		y_index = y_indexes.pick_random()
		yellow_sprite.texture = yellow_sprites[y_index]
	if (t - delay) % start == 0:
		var o_indexes = range(orange_sprites.size())
		o_indexes.remove_at(o_index)
		o_index = o_indexes.pick_random()
		orange_sprite.texture = orange_sprites[o_index]
	if (t - 2 * delay) % start == 0:
		var r_indexes = range(red_sprites.size())
		r_indexes.remove_at(r_index)
		r_index = r_indexes.pick_random()
		red_sprite.texture = red_sprites[r_index]

func _emit_particles():
	var particles_instance = particles.instantiate()
	particles_instance.position = global_position
	$"..".add_child(particles_instance)
	for particle in particles_instance.get_child(0).get_children():
		particle.modulate = Color(2, 2, 1)
		particle.restart()

func _on_timer_timeout() -> void:
	position = player.global_position - Vector2(-30, 1000)
	apply_impulse(Vector2(100, fireball_impulse * 2))
