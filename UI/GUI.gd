extends Control
# Handles the game's graphical user interface


# ENGINE METHODS

# Hide Nodes not needed in Main Menu
# Set UI scale
func _ready() -> void:
	hideAllObjects()
	setScale()

# METHODS

# Hides all UI Objects apart from Nodes that are scenario-dependent
# like the UI blur and pause menu
# Specifically used before starting a new game
func hideAllObjects() -> void:
	$VBoxEconomy.hide()
	$Shovel.hide()
	$ProgressBar.hide()

# Shows all UI Objects apart from Nodes that are scenario-dependent
# like the UI blur and pause menu
# Specifically used when starting a new game
func showAllObjects() -> void:
	$VBoxEconomy.show()
	$Shovel.show()

# Resets the game's UI to its original state
# Adds main menu
# Removes Pause Menu since it shouldn't be used in the main menu
# Hides all gameplay related UI
func resetGameUI() -> void:
	var mainMenu: CenterContainer = Entities.MainMenu.instance()
	add_child(mainMenu)
	
	$ProgressBar.setValue(0)
	setBlur(Global.UI_BLUR_AMOUNT)
	get_node("PauseMenu").queue_free()
	hideAllObjects()
	setScale(Global.UI_SCALE)
	get_tree().paused = false

# Set the whole UI scale, meaning rescaling every child
# If a child has a specific method for overriding scaling behavior
# that one is used, otherwise the node is scaled normally
# Hide Nodes not needed in Main Menu
func setScale(scale: Vector2 = Global.UI_SCALE) -> void:
	for x in get_children():
			if x.has_method("setScale"):
				x.setScale(scale)
			else:
				x.rect_scale = scale

# Sets the intensity of the UI background blur shader
func setBlur(amount: float) -> void:
	$Blur.material.set("shader_param/amount", amount)
