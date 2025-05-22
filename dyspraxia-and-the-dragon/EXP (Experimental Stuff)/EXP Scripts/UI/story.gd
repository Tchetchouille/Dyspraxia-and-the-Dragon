extends Control

var page_number
#@onready var prev_button = $BookContent/Flip/LeftFLip
@onready var next_button = $BookContent/Flip/RightFlip
@onready var begin_button = $BookContent/Flip/BeginGame
@onready var book = $"BookContent"
@onready var story_audio_01 = "res://Assets/Sounds/story01.mp3"
var story_audios = []

func _ready() -> void:
	$"../Main/Music".stream = load("res://Assets/Musics/Thaxted.mp3")
	$"../Main/Music".play()
	page_number = 1
	#prev_button.disabled = true
	#prev_button.visible = false
	begin_button.disabled = true
	begin_button.visible = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("page_left") and page_number != 1:
		go_to_prev_page()
	if Input.is_anything_pressed() and begin_button.visible == true and page_number == 4:
		begin_game()
	elif Input.is_anything_pressed() and next_button.visible == true:
		go_to_next_page()

func _on_left_f_lip_pressed() -> void:
	go_to_prev_page()

func _on_right_flip_pressed() -> void:
	go_to_next_page()

func go_to_next_page():
	$FlippingPages.play()
	book.get_child(page_number-1).visible = false
	page_number += 1
	book.get_child(page_number-1).visible = true
<<<<<<< Updated upstream
<<<<<<< Updated upstream
	if page_number == 4:
		next_button.disabled = true
		next_button.visible = false
		begin_button.disabled = false
		begin_button.visible = true
	#if page_number == 2:
		#prev_button.disabled = false
		#prev_button.visible = true
=======
=======
>>>>>>> Stashed changes
	book.get_child(page_number-1)
	match page_number:
		2:
			#prev_button.disabled = false
			#prev_button.visible = true
			next_button.disabled = true
			next_button.visible = false
			$"BookContent/2/StoryAudio3".play()
		3:
			next_button.disabled = true
			next_button.visible = false
			$"BookContent/3/StoryAudio5_1".play()
		4:
			next_button.disabled = true
			next_button.visible = false
			$"BookContent/4/StoryAudio7".play()
			#next_button.disabled = true
			#next_button.visible = false
			#begin_button.disabled = false
			#begin_button.visible = true

<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes

func go_to_prev_page():
	$FlippingPages.play()
	book.get_child(page_number-1).visible = false
	page_number -= 1
	book.get_child(page_number-1).visible = true
	#if page_number == 1:
		#prev_button.disabled = true
		#prev_button.visible = false
	if page_number == 3:
		next_button.disabled = false
		next_button.visible = true
		begin_button.disabled = true
		begin_button.visible = false

func play_story_audio(index):
	var audio = load(story_audios[index])

func begin_game():
	var info_scene = load("res://EXP (Experimental Stuff)/EXP Scenes/UI/info1.tscn").instantiate()
	get_tree().root.add_child(info_scene)
	queue_free()

func _on_begin_game_pressed() -> void:
	begin_game()



func _on_story_audio_1_finished() -> void:
	$"BookContent/1/StoryAudio2".play()


func _on_story_audio_2_finished() -> void:
	next_button.visible = true
	next_button.disabled = false


func _on_story_audio_3_finished() -> void:
	$"BookContent/2/StoryAudio4".play()


func _on_story_audio_4_finished() -> void:
	next_button.visible = true
	next_button.disabled = false


func _on_story_audio_5_1_finished() -> void:
	$"BookContent/3/StoryAudio5_2".play()


func _on_story_audio_5_2_finished() -> void:
	$"BookContent/3/StoryAudio6".play()


func _on_story_audio_6_finished() -> void:
	next_button.visible = true
	next_button.disabled = false


func _on_story_audio_7_finished() -> void:
	begin_button.visible = true
	begin_button.disabled = false
