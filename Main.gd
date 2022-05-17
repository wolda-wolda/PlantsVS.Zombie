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


func _ready() -> void:
	Global.ui.get_node("Economy/Shop").connect("plant_selected", self, "_onPlantSelected")

func _onPlantSelected(plant: Plant) -> void:
	if !Global.main.has_node("PlacementSystem"):
		var placementSystem = Global.PlacementSystem.instance()
		placementSystem.name = "PlacementSystem"
		add_child(placementSystem)
		placementSystem.start(plant)
