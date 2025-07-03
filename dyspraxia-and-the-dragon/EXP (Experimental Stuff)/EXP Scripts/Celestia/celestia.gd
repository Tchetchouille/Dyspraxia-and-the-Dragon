extends CharacterBody2D

# health of the character
var health = 100
# wether or not character is dyspraxic
var dyspraxia
# triggers on death
signal death

@onready var health_bar = get_node("../MainUi/VBoxContainer/HBoxContainer/PlayerHealth/HealthBar")
@onready var particles = preload("res://EXP (Experimental Stuff)/EXP Scenes/Ennemies/particles_system.tscn")

func _ready() -> void:
	dyspraxia = $"../../Main".global_dyspraxia
	health_bar.init_health(health)
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
	move_and_slide()

func _process(_delta: float) -> void:
	# Gives the possibility to toggle dyspraxia by pressing cntrl
	if Input.is_action_just_pressed("toggle_dyspraxia"):
		dyspraxia = not dyspraxia
	if health <= 0:
		death.emit()

# Taking a hit
func _on_hit_box_body_entered(body: Node2D) -> void:
	health -= body.dmg
	$Sounds/DyspraxiaHurt.get_child(randi_range(0, 2)).play()
	health_bar.set_health(health)
	if body.name != "Dragon":
		body.queue_free()
		_emit_particles(body)
		print(body.name)

# Particles when hit.
func _emit_particles(body):
	var particles_instance = particles.instantiate()
	particles_instance.position = body.global_position
	$"..".add_child(particles_instance)
	for particle in particles_instance.get_child(1).get_children():
		if body is UpFireball:
			particle.modulate = Color(2, 2, 1)
		particle.restart()
