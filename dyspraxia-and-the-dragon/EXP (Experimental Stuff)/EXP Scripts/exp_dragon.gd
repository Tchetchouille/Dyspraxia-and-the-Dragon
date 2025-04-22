extends CharacterBody2D


const health = 100


@onready var health_bar =  get_node("../MainUi/VBoxContainer/HBoxContainer/DragonHealth/HealthBar")


func _ready() -> void:
	health_bar.init_health(health)
