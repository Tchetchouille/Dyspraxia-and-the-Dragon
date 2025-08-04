extends Control

var target
var speed = 8.0
@onready var button1 = $"../Title/VBoxContainer/Buttons/HBoxContainer/Mode Histoire"


func _ready() -> void:
	target = button1.position
	get_viewport().gui_focus_changed.connect(_on_focus_changed)

func _process(delta: float) -> void:
	position = self.position.lerp(target, delta * speed)

func _on_focus_changed(control: Control) -> void:
	if control != null:
		target = control.position
