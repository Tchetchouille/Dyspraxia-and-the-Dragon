extends Node

# Used to adapt the agressivity of the dragon
@export var fireball_threshold : int = 90
@export var claw_threshold : int = 80
# Count of currently available claws
var claw_count : int = 2
# Used to count seconds
var time : float = 0
var rng = RandomNumberGenerator.new()
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
		dragon_action(claw_count)
		time = 0

func dragon_action(c_count):
	# The dragon "rolls a dice". If it is low enough and if a claw is available, it triggers a claw attack.
	# Otherwise, if the roll is low enough, it triggers a fireball attack.
	var chance = rng.randi_range(0, 100)
	if claw_threshold >= chance and claw_count > 0:
		print(chance)
		print("CLAW ATTACK !")
		left_claw_attack.emit()
		right_claw_attack.emit()
	elif fireball_threshold >= chance:
			print(chance)
			print("Fireball")
