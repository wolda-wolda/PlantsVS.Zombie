extends MarginContainer
# Handles the ShopItem along with its UI


# SIGNALS
signal buy_plant(plant)
# VARIABLES
var plant: Plant

# ENGINE METHODS
func _process(delta: float) -> void:
	if $PlantCooldown.is_stopped():
		if Global.balance >= plant.cost:
			modulate = Color(1,1,1)
	else:
		modulate = Color(0.8, 0.8, 0.8)
# Displays the given data on the UI using the plant variable
# and connects a signal for changing the balance on the UI
func _ready() -> void:
	modulate = Color (0.8, 0.8, 0.8)
	$VBoxContainer/TextureRect.texture = plant.texture
	$VBoxContainer/Label.text = str(plant.cost)
	#$PlantCooldown.stop()

# SIGNAL METHODS

# Signals that a plant is about to be bought to the Shop
# Connects a signals to recognize if the plant has been placed
func _on_Button_button_down() -> void:
	if $PlantCooldown.is_stopped():
		if Global.balance >= plant.cost:
			emit_signal("buy_plant", plant)
			Global.main.get_node("PlacementSystem").connect("plant_placed", self, "_on_plant_placed", [], CONNECT_ONESHOT)

func _on_plant_placed() -> void:
	print("cock")
	$PlantCooldown.start(plant.cooldown)

func _on_PlantCooldown_timeout() -> void:
	$PlantCooldown.stop()
