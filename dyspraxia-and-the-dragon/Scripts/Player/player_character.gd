extends CharacterBody2D

@export var player_id: int

# health of the character
var health = 100
# wether or not character is dyspraxic
var dyspraxia
# triggers on death
signal death
var health_path_0 = "../MainUi/VBoxContainer/HBoxContainer/CharacterHealth0/HealthBar"
@onready var health_bar_0 = get_node(health_path_0)
var health_path_1 = "../MainUi/VBoxContainer/HBoxContainer/CharacterHealth1/HealthBar"
@onready var health_bar_1 = get_node(health_path_1)
@onready var particles = preload("res://Scenes/Ennemies/particles_system.tscn")
var damage_display = preload("res://Scenes/UI/damage_display.tscn")

var frame_count = 0
@onready var noise = FastNoiseLite.new()
var original_position : Vector2
var wobble_intensity = 50
var wobble_speed = 0.25
var back_and_forth_speed = 0.05
var back_and_forth_intensity = 0.1


func _ready() -> void:
	original_position = global_position
	noise.seed = randi()
	dyspraxia = $"../../Main".global_dyspraxia
	match player_id:
		0:
			health_bar_0.init_health(health)
		1:
			health_bar_1.init_health(health)
	# Changing character model
	if not dyspraxia:
		$Model/DyspraxiaBody.visible = false
		$Model/CelestiaBody.visible = true
		$RightArm/UpperRightArm/Dyspraxia.visible = false
		$RightArm/UpperRightArm/Celestia.visible = true
		$RightArm/RightHand/Dyspraxia.visible = false
		$RightArm/RightHand/Celestia.visible = true
		$RightArm/LowerRightArm/Dyspraxia.visible = false
		$RightArm/LowerRightArm/Celestia.visible = true
		$LeftArm1/UpperLeftArm/Dyspraxia.visible = false
		$LeftArm1/UpperLeftArm/Celestia.visible = true
		$LeftArm2/LeftHand/Dyspraxia.visible = false
		$LeftArm2/LeftHand/Celestia.visible = true
		$LeftArm2/LowerLeftArm/Dyspraxia.visible = false
		$LeftArm2/LowerLeftArm/Celestia.visible = true
		

# Basic physics
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	wobble()

func _process(_delta: float) -> void:
	# Gives the possibility to toggle dyspraxia by pressing cntrl
	if Input.is_action_just_pressed("toggle_dyspraxia"):
		dyspraxia = not dyspraxia
	if health <= 0:
		death.emit()

# Taking a hit
func _on_hit_box_body_entered(body: Node2D) -> void:
	var damage = body.dmg
	health -= damage
	$Sounds/DyspraxiaHurt.get_child(randi_range(0, 2)).play()
	match player_id:
		0:
			health_bar_0.set_health(health)
		1:
			health_bar_1.set_health(health)
	_emit_particles(body)
	_emit_damage_display(damage, body.position)
	body.queue_free()
	Engine.time_scale = 0.1
	await get_tree().create_timer(0.1, true, false, true).timeout
	Engine.time_scale = 1

# Particles when hit.
func _emit_particles(body):
	var particles_instance = particles.instantiate()
	particles_instance.position = body.global_position
	$"..".add_child(particles_instance)
	for particle in particles_instance.get_child(1).get_children():
		if body is UpFireball:
			particle.modulate = Color(2, 2, 1)
		particle.restart()
		
func _emit_damage_display(dmg, pos):
	var damage_display_instance = damage_display.instantiate()
	damage_display_instance.position = pos
	damage_display_instance.get_child(0).text = "%s" % [str(dmg)]
	damage_display_instance.get_child(0).set("theme_override_font_sizes/normal_font_size", 30 + dmg)
	damage_display_instance.get_child(0).set("theme_override_constants/outline_size", 15 + dmg)
	$"..".add_child(damage_display_instance)

func wobble():
	frame_count += 1
	var noise_x = noise.get_noise_1d(frame_count * wobble_speed + (player_id * 10 + 10)) * wobble_intensity
	var noise_y = noise.get_noise_1d((frame_count + 500.0) * wobble_speed + (player_id * 10 + 10)) * wobble_intensity
	var noise_position = Vector2(noise_x, noise_y)
	var back_and_forth_x = cos(frame_count * back_and_forth_speed + (player_id * 10 + 10))
	var back_and_forth_y = -abs(sin(frame_count * back_and_forth_speed + (player_id * 10 + 10)))
	var back_and_forth = Vector2(back_and_forth_x, back_and_forth_y) * 10
	rotate(deg_to_rad((-sin(frame_count * back_and_forth_speed + (player_id * 10 + 10)) * back_and_forth_intensity - cos(frame_count * back_and_forth_speed + (player_id * 10 + 10))) * back_and_forth_intensity))
	global_position = original_position + noise_position + back_and_forth
	
