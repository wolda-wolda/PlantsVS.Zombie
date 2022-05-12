extends VBoxContainer
# handles the Shop along with its UI


var ShopItem: PackedScene = preload("res://UI/ShopItem.tscn")

# SIGNALS
signal plant_selected(plant)

# ENGINE METHODS

# Creates the Shopitems and connects the needed signals
func _ready() -> void:
	for x in Directories.getEntities(Directories.dirPlants):
		var shopItem: MarginContainer = ShopItem.instance()
		shopItem.plant = load(x)
		shopItem.connect("buy_plant", self, "_on_buy_plant")
		add_child(shopItem)

# SIGNAL METHODS

# Signals the plant select to the Main Node
func _on_buy_plant(plant: Plant) -> void:
	emit_signal("plant_selected", plant)
