extends TextureProgress
# Progress bad to display the match progress

#GETTERS

# Get the progress value
func getValue() -> float:
	return value

# SETTERS

# Set the progress value
func setValue(newValue : int) -> void:
	value = newValue

# Set the maximum value of the progress bar
func setMax(newMax: int)  -> void:
	max_value = newMax
