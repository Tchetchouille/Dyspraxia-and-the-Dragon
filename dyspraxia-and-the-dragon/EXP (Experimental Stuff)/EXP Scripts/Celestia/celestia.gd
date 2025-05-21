extends CharacterBody2D


const SPEED = 750.0
const JUMP_VELOCITY = -1500.0
const JUMP_DYSPRAXIA = 100
var health = 100
var dyspraxia
signal death

@onready var health_bar = get_node("../MainUi/VBoxContainer/HBoxContainer/PlayerHealth/HealthBar")
@onready var particles = preload("res://EXP (Experimental Stuff)/EXP Scenes/Ennemies/particles_system.tscn")

func _ready() -> void:
	dyspraxia = $"../../Main".global_dyspraxia
	health_bar.init_health(health)
	if not dyspraxia:
		$Model/DyspraxiaBody.visible = false
		$Model/CelestiaBody.visible = true


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if dyspraxia == true:
		dyspraxia_process(delta)
	else:
		celestia_process(delta)
	move_and_slide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_dyspraxia"):
		dyspraxia = not dyspraxia
	if health <= 0:
		death.emit()

func _on_hit_box_body_entered(body: Node2D) -> void:
	health -= body.dmg
	$Sounds/DyspraxiaHurt.get_child(randi_range(0, 2)).play()
	health_bar.set_health(health)
	if body.name != "ExpRightClaw" and body.name != "ExpLeftClaw" and body.name != "Dragon":
		body.queue_free()
		_emit_particles(body)
		print(body.name)

func _emit_particles(body):
	var particles_instance = particles.instantiate()
	particles_instance.position = body.global_position
	$"..".add_child(particles_instance)
	for particle in particles_instance.get_child(1).get_children():
		if body is UpFireball:
			particle.modulate = Color(0, 1, 1)
		particle.restart()

func dyspraxia_process(_delta):
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		# For Dyspraxia, we add a little randomness to throw the player off
		velocity.y = JUMP_VELOCITY + randf_range(-JUMP_DYSPRAXIA, JUMP_DYSPRAXIA)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func celestia_process(_delta):
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
