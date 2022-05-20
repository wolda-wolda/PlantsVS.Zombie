extends Node
class_name PlantCreator
# Class which is used to create a new plant from a PlantBlueprint
# using a Plant Resource


# VARIABLES
var createdPlant: Node2D

# ENGINE METHODS

# Creates a new plant and assigns it the Plant Class' parameters
func _init(plant: Plant) -> void:
	createdPlant = Entities.PlantBlueprint.instance()
	createdPlant.set_script(plant.plantScript)
	createdPlant.maxHP = plant.hp
	createdPlant.cost = plant.cost
	createdPlant.attackInterval = plant.attackInterval
	createdPlant.attackRange = plant.attackRange
	createdPlant.get_node("States/State0").frames = plant.spriteFrames0
	createdPlant.get_node("States/State1").frames = plant.spriteFrames1
	createdPlant.get_node("States/State2").frames = plant.spriteFrames2
	for x in createdPlant.get_node("States").get_children():
		x.speed_scale = plant.animationSpeedScale

# METHODS

# Return the created plant as a Node2D
func getPlant() -> Node2D:
	return createdPlant
