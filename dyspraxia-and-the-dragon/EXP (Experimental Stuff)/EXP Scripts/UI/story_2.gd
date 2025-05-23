extends Control

var page_number
@onready var prev_button = $BookContent/Flip/HBoxContainer/LeftFLip
@onready var next_button = $BookContent/Flip/HBoxContainer/RightFlip
@onready var begin_button = $BookContent/Flip/HBoxContainer/BeginGame
@onready var book = $"BookContent"
@onready var story_audio_01 = "res://Assets/Sounds/story01.mp3"
var story_audios = []

func _ready() -> void:
	$"../Main/Music".stream = load("res://Assets/Musics/Thaxted.mp3")
	$"../Main/Music".play()

func _process(_delta: float) -> void:
	if Input.is_anything_pressed() and $BookContent/Flip/HBoxContainer/BeginGame.visible == true:
		begin_game()

func play_story_audio(index):
	var audio = load(story_audios[index])

func begin_game():
	var dyspraxia_fight_scene = load("res://EXP (Experimental Stuff)/EXP Scenes/UI/info2.tscn").instantiate()
	get_tree().root.add_child(dyspraxia_fight_scene)
	queue_free()

func _on_begin_game_pressed() -> void:
	begin_game()


func _on_story_audio_1_finished() -> void:
	$"BookContent/1/StoryAudio2_1".play()


func _on_story_audio_2_1_finished() -> void:
	$"BookContent/1/StoryAudio2_2".play()


func _on_story_audio_2_2_finished() -> void:
	begin_button.visible = true
	begin_button.disabled = false
