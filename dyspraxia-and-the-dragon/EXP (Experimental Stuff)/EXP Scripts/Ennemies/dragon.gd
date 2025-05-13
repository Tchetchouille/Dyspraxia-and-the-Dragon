extends CharacterBody2D


var health = 100
signal death

var fireball = preload("res://EXP (Experimental Stuff)/EXP Scenes/Ennemies/exp_fireball.tscn")
@onready var health_bar =  get_node("../MainUi/VBoxContainer/HBoxContainer/DragonHealth/HealthBar")
@onready var animation_frames = [
	$Animation/DownOpen,
	$Animation/RestDown,
	$Animation/RestUp,
	$Animation/UpOpen
]
var current_frame = 1
var next_frame = 0
var animation_state = "rest"
var target_frame = 2

func _ready() -> void:
	health_bar.init_health(health)
	# Animation setup. Deactivating every animation "frame" and reactivating the initial one.
	for frame in animation_frames:
		frame.set_process(false)
		frame.visible = false
	animation_frames[current_frame].set_process(true)
	animation_frames[current_frame].visible = true



func _process(_delta: float) -> void:
	if health <= 0:
		death.emit()


func _on_hit_box_body_entered(body: Node2D) -> void:
	health -= 5
	health_bar.set_health(health)
	body.queue_free()

func _animate(frame_index):
	animation_frames[current_frame].set_process(false)
	animation_frames[current_frame].visible = false
	animation_frames[frame_index].set_process(true)
	animation_frames[frame_index].visible = true


func _on_animation_timer_timeout() -> void:
	# If the target is reached, we define the next target
	if next_frame == target_frame:
		# We define the next target based on the animation state
		match animation_state:
			"rest":
				if current_frame < target_frame:
					target_frame = 1
				elif current_frame > target_frame:
					target_frame = 2
			"down_fireball":
				animation_state = "rest"
				var fb_instance = fireball.instantiate()
				$"..".add_child(fb_instance)
				target_frame = 0
			"up_fireball":
					target_frame = 3
	_animate(next_frame)
	current_frame = next_frame
	if next_frame > target_frame:
		next_frame -= 1
	elif next_frame < target_frame:
		next_frame += 1
	print(str(current_frame) + " " + str(next_frame))	
	


func _on_game_manager_down_fireball() -> void:
	animation_state = "down_fireball"
