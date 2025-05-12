extends CharacterBody2D


var health = 100
signal death

@onready var health_bar =  get_node("../MainUi/VBoxContainer/HBoxContainer/DragonHealth/HealthBar")


func _ready() -> void:
	health_bar.init_health(health)



func _process(_delta: float) -> void:
	if health <= 0:
		death.emit()


func _on_hit_box_body_entered(body: Node2D) -> void:
	health -= 5
	health_bar.set_health(health)
	body.queue_free()
