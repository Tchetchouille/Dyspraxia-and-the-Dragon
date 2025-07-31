extends CharacterBody2D


var health = 100
signal death

# Sound effects
@onready var down_fireball_sounds = $SoundEffects/DownFireballSounds
@onready var up_fireball_sounds = $SoundEffects/UpFireballSounds
@onready var dragon_hurt_sounds = $SoundEffects/DragonHurtSounds

var up_fireball_scene = preload("res://Scenes/Ennemies/big_fireball.tscn")
var down_fireball_scene = preload("res://Scenes/Ennemies/small_fireball.tscn")
var particles = preload("res://Scenes/Ennemies/particles_system.tscn")
var damage_display = preload("res://Scenes/UI/damage_display.tscn")
@onready var health_bar =  get_node("../MainUi/VBoxContainer/HBoxContainer/CharacterHealth1/HealthBar")
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
	var damage = int(body.dmg * body.linear_velocity.length() / 1000)
	if body is UpFireball:
		health -= damage
	else:
		health -= damage
	health_bar.set_health(health)
	body.queue_free()
	_emit_particles(body)
	_emit_damage_display(damage, body.position)
	dragon_hurt_sounds.get_child(randi_range(0, 3))



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
