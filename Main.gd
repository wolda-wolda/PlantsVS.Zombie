""" Plant vs. Zombie in Godot Copyright (C) 2022 Marcel Walder, Max Palfrader, Simran Kaur, Niels Bock
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
"""

extends Node2D


# ENGINE METHODS

func _ready() -> void:
	var homeLevel: Node2D = Entities.HomeLevel.instance()
	homeLevel.name = "HomeLevel"
	add_child(homeLevel)
	Global.GUI.get_node("VBoxEconomy/Shop").connect("plant_selected", self, "_onPlantSelected")
	#Global.GUI.hideAllObjects()
	Global.GUI.setBlur(2.8)

# METHODS

# Add and start a placement system if there isn't already one
func addPlacementSystem(mode: int, plant: Node2D) -> void:
	if !has_node("PlacementSystem"):
		var placementSystem: Node2D = Entities.PlacementSystem.instance()
		placementSystem.name = "PlacementSystem"
		add_child(placementSystem)
		placementSystem.start(mode, plant)

# SIGNAL METHODS

# Create a plant creator and add it into a new placementsystem
# After the placement system terminated, free it
func _onPlantSelected(plant: Plant) -> void:
	var plantCreator: PlantCreator = PlantCreator.new(plant)
	addPlacementSystem(Global.mode.PLACE, plantCreator.getPlant())
	plantCreator.queue_free()
	
