extends Node

# Used to adapt the agressivity of the dragon
@export var down_fireball_threshold : int = 60
@export var up_fireball_threshold : int = 20
@export var claw_threshold : int = -10
@onready var player = $"../CelestiaCharacter"
# Count of currently available claws
var claw_count : int = 2
# Used to count seconds
var time : float = 0
var rng = RandomNumberGenerator.new()
# Signal used to trigger the claw attacks
signal left_claw_attack(target)
signal right_claw_attack(target)
# Signal used to trigger the fireballs attack
signal up_fireball()
signal down_fireball()
# Array containing the claws that are available for attacks
var available_claws : Array = [left_claw_attack, right_claw_attack]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Triggers a dragon action every second
	time += delta
	if time >= 0.5:
		dragon_action(player.position)
		time = 0

func dragon_action(target):
	# The dragon "rolls a dice". If it is low enough and if a claw is available, it triggers a claw attack.
	# Otherwise, if the roll is low enough, it triggers a fireball attack.
	var chance = rng.randi_range(0, 100)
	if claw_threshold >= chance and available_claws.size() > 0:
		claw_attack(target)
	
	elif up_fireball_threshold >= chance:
		up_fireball_attack() 

	elif down_fireball_threshold >= chance:
		down_fireball_attack()

func claw_attack(target):
	var r = rng.randi_range(0, available_claws.size()-1)
	available_claws[r].emit(target)
	available_claws.remove_at(r)

func down_fireball_attack():
	down_fireball.emit()

func up_fireball_attack():
	up_fireball.emit()

# When the claw has finished attacking, it sends a signal
func _on_exp_left_claw_available() -> void:
	# We check that the claw attack signal is not avaiable, as to avoid multiples in the array
	if available_claws.has(left_claw_attack) == false:
		# We add the signal to the list of available claw attacks
		available_claws.append(left_claw_attack)

# When the claw has finished attacking, it sends a signal
func _on_exp_right_claw_available() -> void:
	# We check that the claw attack signal is not avaiable, as to avoid multiples in the array
	if available_claws.has(right_claw_attack) == false:
		# We add the signal to the list of available claw attacks
		available_claws.append(right_claw_attack)


func _on_exp_dragon_death() -> void:
	var dyspraxia_win_scene = load("res://EXP (Experimental Stuff)/EXP Scenes/UI/win1.tscn").instantiate()
	get_tree().root.add_child(dyspraxia_win_scene)
	$"..".queue_free()

func _on_exp_celestia_character_death() -> void:
	var dyspraxia_game_over_scene = load("res://EXP (Experimental Stuff)/EXP Scenes/UI/game_over.tscn").instantiate()
	get_tree().root.add_child(dyspraxia_game_over_scene)
	$"..".queue_free()
