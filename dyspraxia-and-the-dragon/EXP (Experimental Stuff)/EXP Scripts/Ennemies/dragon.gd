extends CharacterBody2D


var health = 100
signal death

# Sound effects
@onready var down_fireball_sounds = $SoundEffects/DownFireballSounds
@onready var up_fireball_sounds = $SoundEffects/UpFireballSounds
@onready var dragon_hurt_sounds = $SoundEffects/DragonHurtSounds

var up_fireball_scene = preload("res://EXP (Experimental Stuff)/EXP Scenes/Ennemies/exp_up_fireball.tscn")
var down_fireball_scene = preload("res://EXP (Experimental Stuff)/EXP Scenes/Ennemies/exp_fireball.tscn")
var particles = preload("res://EXP (Experimental Stuff)/EXP Scenes/Ennemies/particles_system.tscn")
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
	if body is UpFireball:
		health -= 10
	else:
		health -= 5
	health_bar.set_health(health)
	body.queue_free()
	_emit_particles(body)
	dragon_hurt_sounds.get_child(randi_range(0, 3))



func _emit_particles(body):
	var particles_instance = particles.instantiate()
	particles_instance.position = body.global_position
	$"..".add_child(particles_instance)
	for particle in particles_instance.get_child(1).get_children():
		if body is UpFireball:
			particle.modulate = Color(2, 2, 1)
		particle.restart()


func _on_animation_timer_timeout() -> void:
	# If we have reached the animation target, we define the next one
	if current_frame == target_frame:
		match current_frame:
			top_fb_frame:
				target_frame = top_rest_frame
				if up_fireball:
					var fb_instance = up_fireball_scene.instantiate()
					$"..".add_child(fb_instance)
					up_fireball_sounds.get_child(randi_range(0, 2)).play()
					up_fireball = false
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
					var fb_instance = down_fireball_scene.instantiate()
					down_fireball_sounds.get_child(randi_range(0, 2)).play()
					$"..".add_child(fb_instance)
					down_fireball = false
	# Animating
	_animate()
	# We then update the current and last frames
	last_frame = current_frame
	if current_frame < target_frame:
		current_frame += 1
	elif current_frame > target_frame:
		current_frame -= 1
	

func _animate():
	animation_frames[last_frame].get_child(1).set_collision_mask_value(8, false)
	animation_frames[last_frame].visible = false
	animation_frames[current_frame].get_child(1).set_collision_mask_value(8, true)
	animation_frames[current_frame].visible = true

func _on_game_manager_down_fireball() -> void:
	down_fireball = true


func _on_game_manager_up_fireball() -> void:
	up_fireball = true
