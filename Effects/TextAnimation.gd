extends CenterContainer
# Scene which can animate a given text to scale in


# EXPORT VARIABLES

export(String) var text

# ENGINE METHODS

func _ready() -> void:
	$Label.text = text

# METHODS

# Start the animation
func startAnimation() -> void:
	var tween: = Tween.new()
	tween.interpolate_property($Label, "rect_scale", Vector2(1,1), Vector2(5,5), 1, Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	add_child(tween)
	tween.start()

# SIGNAL METHODS

# Start the animation, as soon as the text is ready
# and the node has been resized
func _on_Label_resized() -> void:
	$Label.rect_pivot_offset = $Label.rect_size / 2
	startAnimation()
