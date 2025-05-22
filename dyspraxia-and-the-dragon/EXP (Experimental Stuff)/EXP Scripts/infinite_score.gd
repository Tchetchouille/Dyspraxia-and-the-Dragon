extends RichTextLabel

var format_string = " Score : %s"
var score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score += abs(100 - $"../../../../../Dragon".health)
	$"../../../../../Dragon".health = 100
	var actual_string = format_string % score
	text = actual_string
