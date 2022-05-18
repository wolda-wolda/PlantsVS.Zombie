extends MarginContainer
# Tooltip for ShopItems to show a plants properties


# METHODS

# Set the values which are relevant on the UI using a Plant Resource
func setValues(plant: Plant) -> void:
	$VBoxContainer/TitleFrame/TitleFrameLabel.bbcode_text = "[center]" + plant.name + "[/center]"
	var hp: int = plant.hp
	var cooldown: int = plant.cooldown
	var attackInterval: int = plant.attackInterval
	var attackRange: int = plant.attackRange
	$VBoxContainer/MainFrame/MainFrameLabel.bbcode_text = "[center][color=green]HP[/color] " + str(hp)\
	+ "\n[color=yellow]Cooldown[/color] " + str(plant.cooldown)
	if attackInterval != 0:
		$VBoxContainer/MainFrame/MainFrameLabel.bbcode_text += " Seconds\n" + "[color=red]Attack Interval[/color] " +\
		str(plant.attackInterval) + " Seconds\n"
	if attackRange != 0:
		$VBoxContainer/MainFrame/MainFrameLabel.bbcode_text += "[color=red]Attack Range[/color] " +\
		str(plant.attackRange) + " Units[/center]"
	$VBoxContainer/MainFrame/MainFrameLabel.centerText()
