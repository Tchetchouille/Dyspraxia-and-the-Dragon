extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var score = $"../../../../Main".global_score
	var actual_text = "[center]Score: %d[/center]" % score
	text = actual_text
