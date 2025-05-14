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
var top_fb_frame
var top_rest_frame = 2
var bottom_rest_frame = 1
var bottom_fb_frame = 0
	
# Animation variables
var up_fireball = false
var down_fireball = false
var target_frame = 2
var current_frame = 1
var last_frame = 2

func _ready() -> void:
	health_bar.init_health(health)
	# Animation setup. Deactivating every animation "frame" and reactivating the initial one.
	for frame in animation_frames:
		frame.set_process(false)
		frame.visible = false
	animation_frames[current_frame].set_process(true)
	animation_frames[current_frame].visible = true
	top_fb_frame = animation_frames.size() -1



func _process(_delta: float) -> void:
	if health <= 0:
		death.emit()


func _on_hit_box_body_entered(body: Node2D) -> void:
	health -= 5
	health_bar.set_health(health)
	body.queue_free()


func _on_animation_timer_timeout() -> void:
	# If we have reached the animation target, we define the next one
	if current_frame == target_frame:
		match current_frame:
			top_fb_frame:
				target_frame = top_rest_frame
			top_rest_frame:
				if up_fireball:
					target_frame = top_fb_frame
				else:
					target_frame = bottom_rest_frame
			bottom_rest_frame:
				if down_fireball:
					target_frame = bottom_fb_frame
				else:
					target_frame = top_rest_frame
			bottom_fb_frame:
				target_frame = bottom_rest_frame
				if down_fireball:
					var fb_instance = fireball.instantiate()
					$"..".add_child(fb_instance)
					down_fireball = false
	# Animating
	_animate()
	print(str(current_frame) + " " + str(target_frame))
	# We then update the current and last frames
	last_frame = current_frame
	if current_frame < target_frame:
		current_frame += 1
	elif current_frame > target_frame:
		current_frame -= 1
	

func _animate():
	animation_frames[last_frame].set_process(false)
	animation_frames[last_frame].visible = false
	animation_frames[current_frame].set_process(true)
	animation_frames[current_frame].visible = true

func _on_game_manager_down_fireball() -> void:
	down_fireball = true
