@tool
extends RichTextEffect
class_name RichTextMinusCurve

var bbcode := "-curve"

func _process_custom_fx(char_fx):
	# Mapping index to give seed between 0 and 90
	var curve_seed = deg_to_rad((char_fx.relative_index + 0.5) * 180 / 6)
	char_fx.offset += Vector2(0, sin(curve_seed) * 30)
