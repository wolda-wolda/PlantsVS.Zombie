extends MarginContainer
# Handles the ShopItem along with its UI


# SIGNALS

signal buy_plant(plant)

# VARIABLES

var plant: Plant
var plantInfo: MarginContainer

# ENGINE METHODS

# Displays the given data on the UI using the plant variable
# and connects a signal for changing the balance on the UI
func _ready() -> void:
	$VBoxContainer/TextureRect.texture = plant.texture
	$VBoxContainer/Label.text = str(plant.cost)
	$PlantCooldown.stop()
	Global.connect("balance_changed", self, "_on_balance_changed")
	_on_balance_changed()

# Updates the cooldown indicator on the UI
func _process(_delta: float) -> void:
	$Cooldown.setValue(100 / plant.cooldown * $PlantCooldown.time_left)

# UI updates

# Toggle the availability of the shop item on the UI
func _setAvailable(available: bool) -> void:
	if available:
		$Button.disabled = false
		modulate = Color(1, 1, 1)
	else:
		$Button.disabled = true
		modulate = Color(0.78, 0.78, 0.78)

# Toggle the visibility of the tooltip on the UI
func _showTooltip() -> void:
	$Frame/PlantInfo.setValues(plant)
	$Frame/PlantInfo.show()
	$TooltipTimer.stop()


# SIGNAL METHODS

# Signals that a plant is about to be bought to the Shop
# Connects a signals to recognize if the plant has been placed
func _on_Button_button_down() -> void:
	if $PlantCooldown.is_stopped():
		emit_signal("buy_plant", plant)
		if !Global.main.get_node("PlacementSystem").is_connected("plant_placed", self, "_on_plant_placed"):
			Global.main.get_node("PlacementSystem").connect("plant_placed", self, "_on_plant_placed", [], CONNECT_ONESHOT)

# Stop the timer when it timed out so it doesn't restart
func _on_PlantCooldown_timeout() -> void:
	$PlantCooldown.stop()

# Restart the cooldown when a plant has been placed so that it can't
# be instantly rebought
func _on_plant_placed() -> void:
	Global.balance -= plant.cost
	$PlantCooldown.start(plant.cooldown)

# Toggle the availability of the plant by checking the balance
func _on_balance_changed() -> void:
	if Global.balance >= plant.cost:
		_setAvailable(true)
	else:
		_setAvailable(false)

# Start the countdown for displaying the tooltip when it times out
func _on_Button_mouse_entered() -> void:
	$TooltipTimer.start(Global.TOOLTIP_DELAY)

# Stop the countdown and hide the tooltip if it was displayed
# in case the mouse exits the shop item
func _on_Button_mouse_exited() -> void:
	$Frame/PlantInfo.hide()
	$TooltipTimer.stop()

# Show the tooltip in case the cooldown reached zeross
func _on_TooltipTimer_timeout() -> void:
	_showTooltip()
