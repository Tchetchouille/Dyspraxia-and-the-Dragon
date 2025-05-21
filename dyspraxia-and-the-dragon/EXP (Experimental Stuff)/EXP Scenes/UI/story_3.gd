extends Control

var page_number
@onready var prev_button = $BookContent/Flip/HBoxContainer/LeftFLip
@onready var next_button = $BookContent/Flip/HBoxContainer/RightFlip
@onready var begin_button = $BookContent/Flip/HBoxContainer/Back
@onready var book = $"BookContent"
@onready var story_audio_01 = "res://Assets/Sounds/story01.mp3"
var story_audios = []

func _ready() -> void:
	$"../Main/Music".stream = load("res://Assets/Musics/Thaxted.mp3")
	$"../Main/Music".play()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("page_right"):
		back_to_main_menu()

func play_story_audio(index):
	var audio = load(story_audios[index])

func back_to_main_menu():
	var dyspraxia_fight_scene = load("res://EXP (Experimental Stuff)/EXP Scenes/UI/main_menu.tscn").instantiate()
	get_tree().root.add_child(dyspraxia_fight_scene)
	queue_free()

func _on_back_pressed() -> void:
	back_to_main_menu()
