extends ProgressBar

# Shamelessly stolen from: https://www.youtube.com/watch?v=f90ieBOoIYQ

@onready var timer = $Timer
@onready var damage_bar = $DamageBar


signal game_over

var health = 0
# Used to hold values sent by player scene before the health bar is fully instantiated
var db_max_value
var db_value


func _ready() -> void:
	damage_bar.max_value = db_max_value
	damage_bar.value = db_value


func set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	var tween = create_tween()
	tween.tween_property(self, "value", health, 0.15)
	
	if health <= 0:
		game_over.emit()
	
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health


func init_health(_health):
	health = _health
	max_value = health
	value = health
	db_max_value = health
	db_value = health



func _on_timer_timeout() -> void:
	# damage_bar.value = health
	var tween = create_tween()
	tween.tween_property(damage_bar, "value", health, 0.15)
