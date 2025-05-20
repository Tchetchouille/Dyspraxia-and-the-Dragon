extends Node

func _ready() -> void:
	if $"../Main/Music".stream != load("res://Assets/Musics/The Show Must Be Go.mp3"):
		$"../Main/Music".stream = load("res://Assets/Musics/The Show Must Be Go.mp3")
		$"../Main/Music".play()
