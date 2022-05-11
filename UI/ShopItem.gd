extends MarginContainer
# Handles the ShopItem along with its UI


# SIGNALS
signal buy_plant(plant)

# VARIABLES
var plant: Plant

# ENGINE METHODS

# Displays the given data on the UI using the plant variable
# and connects a signal for changing the balance on the UI
func _ready() -> void:
	$VBoxContainer/TextureRect.texture = plant.texture
	$VBoxContainer/Label.text = str(plant.cost)

# SIGNAL METHODS

# Signals that a plant is about to be bought to the Shop
# Connects a signals to recognize if the plant has been placed
func _on_Button_button_down() -> void:
	emit_signal("buy_plant", plant)
	Global.main.get_node("PlacementSystem").connect("plant_placed", self, "_on_plant_placed", [], CONNECT_ONESHOT)
