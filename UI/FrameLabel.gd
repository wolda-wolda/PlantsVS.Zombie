extends RichTextLabel
# Textlabel are which supports rich text and can align vertically
# on top of the other RichTextLabel functionality


# CONSTANTS

const MAX_LINES: int = 4

# ENGINE METHODS

# Sets the rect size to fit the parent and offsets the position by 2
# so that the text doesn't clip into the frame
func _ready() -> void:
	rect_size.x = get_parent().rect_size.x
	rect_position.y = 2

# METHODS

# Center the text in the label
func centerText() -> void:
	var lineOffset: int = rect_size.y / MAX_LINES / 2
	rect_position.y = 2 + lineOffset * (MAX_LINES - _getLines(bbcode_text))

# Return the lines in the current text
func _getLines(textString: String) -> int:
	return textString.split("\n", false).size()
