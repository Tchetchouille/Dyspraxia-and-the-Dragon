extends Node

# Used to adapt the agressivity of the dragon
@export var fireball_threshold : int = 90
@export var claw_threshold : int = 30
var fireball = preload("res://EXP (Experimental Stuff)/EXP Scenes/exp_fireball.tscn")
# Count of currently available claws
var claw_count : int = 2
# Used to count seconds
var time : float = 0
var rng = RandomNumberGenerator.new()
# Array containing the claws that are available for attacks
@export var available_claws : Array = []
# Signal used to trigger the claw attacks
signal left_claw_attack
signal right_claw_attack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Triggers a dragon action every second
	time += delta
	if time >= 1:
		dragon_action()
		time = 0

func dragon_action():
	# The dragon "rolls a dice". If it is low enough and if a claw is available, it triggers a claw attack.
	# Otherwise, if the roll is low enough, it triggers a fireball attack.
	var chance = rng.randi_range(0, 100)
	if claw_threshold >= chance and available_claws.size() > 0:
		print(chance)
		claw_attack()

	elif fireball_threshold >= chance:
		print(chance)
		fireball_attack()
		

func claw_attack():
	print("CLAW ATTACK !")
	left_claw_attack.emit()
	right_claw_attack.emit()

func fireball_attack():
	print("Fireball")
	var fb_instance = fireball.instantiate()
	$"..".add_child(fb_instance)
	
	
