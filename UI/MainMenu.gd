extends CenterContainer
# Handles the Main Menu


# METHODS

# Method used for "overriding" how the scale is set
func setScale(scale: Vector2) -> void:
	rect_scale = scale
	rect_size /= scale

# SIGNAL METHODS

# Quit the game
func _on_Exit_pressed():
	get_tree().quit()

# Hides old buttons and shows new ones
func _on_Play_pressed():
	$VBoxContainer/Play.visible = false
	$VBoxContainer/MultiPlayer.visible = true
	$VBoxContainer/SinglePlayer.visible = true

# Handles the process of starting a new game
# when this button has been clicked
# and adjusts relevant UI elements
func _on_SinglePlayer_pressed():
	Global.main.addMainLevel()
	
	var pauseMenu: MarginContainer = Entities.PauseMenu.instance()
	pauseMenu.visible = false
	pauseMenu.rect_scale = Global.UI_SCALE
	Global.GUI.add_child(pauseMenu)
	
	Global.GUI.showAllObjects()
	Global.GUI.setBlur(0.0)
	queue_free()
