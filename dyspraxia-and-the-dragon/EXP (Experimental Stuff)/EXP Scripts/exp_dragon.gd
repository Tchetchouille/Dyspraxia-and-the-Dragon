extends CharacterBody2D


var health = 100


@onready var health_bar =  get_node("../MainUi/VBoxContainer/HBoxContainer/DragonHealth/HealthBar")


func _ready() -> void:
	health_bar.init_health(health)


func _on_hit_box_body_entered(body: Node2D) -> void:
	health -= 5
	health_bar.set_health(health)
