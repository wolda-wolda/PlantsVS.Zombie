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
	addHomeLevel()
	Global.GUI.get_node("VBoxEconomy/Shop").connect("plant_selected", self, "_onPlantSelected")

# METHODS

# Resets all values
# For starting a new game
func reset() -> void:
	Global.balance = 100
	Global.GUI.resetGameUI()
	addHomeLevel()

# Adds a background scene
# Used when player is in main menu
func addHomeLevel() -> void:
	if has_node("MainLevel"):
		get_node("MainLevel").queue_free()
	var homeLevel: Node2D = Entities.HomeLevel.instance()
	homeLevel.name = "HomeLevel"
	add_child(homeLevel)

# Adds the main level
# Used for starting a new game
func addMainLevel() -> void:
	if has_node("HomeLevel"):
		get_node("HomeLevel").queue_free()
	var mainLevel: Node2D = Entities.MainLevel.instance()
	mainLevel.name = "MainLevel"
	add_child(mainLevel)

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
	
