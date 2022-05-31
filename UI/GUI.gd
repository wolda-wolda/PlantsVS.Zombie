extends Control
# Handles the game's graphical user interface


# ENGINE METHODS

# Set the whole UI scale, meaning rescaling every child
# If a child has a specific method for overriding scaling behavior
# that one is used, otherwise the node is scaled normally
func _ready() -> void:
	hideAllObjects()
	$MainMenu.show()
	for x in get_children():
		if x.has_method("setScale"):
			x.setScale(Global.UI_SCALE)
		else:
			x.rect_scale = Global.UI_SCALE

# METHODS

# Hides all UI Objects apart from Effects like blur
func hideAllObjects() -> void:
	for x in get_children():
		$VBoxEconomy.hide()
		$Shovel.hide()
		$ProgressBar.hide()
		$MainMenu.hide()

# Shows all UI Objects apart from Effects like blur
func showAllObjects() -> void:
	for x in get_children():
		$VBoxEconomy.show()
		$Shovel.show()
		$ProgressBar.show()
		$MainMenu.show()
