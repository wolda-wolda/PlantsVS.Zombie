extends MarginContainer
# Handles the shovel for removing plants along with its UI


# METHODS

# Set the scale and realign to be at the correct position
func setScale(scale: Vector2) -> void:
	rect_scale = scale
	rect_position.x -= rect_size.x

# SIGNAL METHODS

# When pressed, create a new placement system in remove-mode
# for removing plants
func _on_Button_button_down() -> void:
	get_node("/root/Main").addPlacementSystem(Global.mode.REMOVE, Entities.Remover.instance())
