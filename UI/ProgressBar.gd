extends TextureProgress
# Progress bad to display the match progress


# VARIABLES

var localValue: int = 0
var tween: Tween

#GETTERS

# Get the progress value
func getValue() -> int:
	return localValue

# SETTERS

# Set the progress value
func setValue(newValue : int) -> void:
	localValue = newValue
	tween = Tween.new()
	tween.interpolate_property(self, "value", value, localValue, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	add_child(tween)
	tween.start()

# Set the maximum value of the progress bar
func setMax(newMax: int)  -> void:
	max_value = newMax

# SIGNAL METHODS

func _onTweenCompleted() -> void:
	tween.queue_free()
