extends Node2D


func _ready() -> void:
	Global.ui.get_node("Economy/Shop").connect("plant_selected", self, "_onPlantSelected")

func _onPlantSelected(plant: Plant) -> void:
	if !Global.main.has_node("PlacementSystem"):
		var placementSystem = Global.PlacementSystem.instance()
		placementSystem.name = "PlacementSystem"
		add_child(placementSystem)
		placementSystem.start(plant)
