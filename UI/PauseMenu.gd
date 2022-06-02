extends MarginContainer
# Handles pausing and unpausing the game along with its UI


# ENGINE METHODS

# Checks if the ui_cancel action is pressed for pausing
# and unpausing the game
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if visible:
			_fade(Global.fade.OUT)
		else:
			show()
			_fade(Global.fade.IN)
			get_tree().paused = true

# METHODS

# Fade in or out the pause menu using a mode
# Uses mudulate of the pause menu and blur of the background
func _fade(mode: int) -> void:
	if mode == Global.fade.IN:
		$FadeTween.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), Global.UI_ANIMATION_DURATION, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$FadeTween.start()
		$BlurTween.interpolate_property(Global.Blur.material, "shader_param/amount", 0.0, Global.UI_BLUR_AMOUNT, Global.UI_ANIMATION_DURATION, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$BlurTween.start()
	elif mode == Global.fade.OUT:
		$FadeTween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), Global.UI_ANIMATION_DURATION, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$FadeTween.connect("tween_completed", self, "_on_FadeTween_tween_completed", [], CONNECT_ONESHOT)
		$FadeTween.start()
		$BlurTween.interpolate_property(Global.Blur.material, "shader_param/amount", Global.UI_BLUR_AMOUNT, 0.0, Global.UI_ANIMATION_DURATION, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$BlurTween.start()

# SIGNAL METHODS

# If the Resume button is clicked, fade out the pause menu
# and unpause the game
func _on_ButtonResume_pressed() -> void:
	_fade(Global.fade.OUT)

# Quit the game
func _on_ButtonQuit_pressed() -> void: 
	get_tree().quit()

# When the fadein is completed, unpause the game and hide the pause menu
func _on_FadeTween_tween_completed(object: Object, key: NodePath) -> void:
	get_tree().paused = false
	hide()

# Returns the player to the main menu
func _on_ButtonMainMenu_pressed():
	Global.main.reset()
