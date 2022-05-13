extends Node
class_name PlantCreator
# Class which is used to create a new plant from a PlantBlueprint
# using a Plant Resource

var PlantBlueprint: PackedScene = preload("res://Plants/PlantBlueprint.tscn")

# VARIABLES
var createdPlant: Node2D

# ENGINE METHODS

# Creates a new plant and assigns it the Plant Class' parameters
func _init(plant: Plant) -> void:
	createdPlant = PlantBlueprint.instance()
	createdPlant.set_script(plant.plantScript)
	createdPlant.maxHP = plant.hp
	createdPlant.cost = plant.cost
	createdPlant.attackInterval = plant.attackInterval
	createdPlant.attackRange = plant.attackRange
	createdPlant.get_node("AnimatedSprite").frames = plant.spriteFrames

# METHODS

# Return the created plant as a Node2D
func getPlant() -> Node2D:
	return createdPlant
