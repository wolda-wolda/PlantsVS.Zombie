extends Node
class_name ZombieCreator
# Class which is used to create a new zombie from a ZombieBlueprint
# using a Zombie Resource


# VARIABLES
var createdZombie: Node2D

# ENGINE METHODS

# Creates a new zombie and assigns it the Zombie Class' parameters
func _init(zombie: Zombie) -> void:
	var zombieBlueprint = Entities.ZombieBlueprint.instance()
	zombieBlueprint.set_script(zombie.zombieScript)
	zombieBlueprint.hp = zombie.hp
	zombieBlueprint.cost = zombie.cost
	zombieBlueprint.attackInterval = zombie.attackInterval
	zombieBlueprint.movementSpeed = zombie.movementSpeed
	zombieBlueprint.get_node("Walking").frames = zombie.spriteFramesWalking
	zombieBlueprint.get_node("Eating").frames = zombie.spriteFramesEating
	if zombie.spriteFramesEatingAccessory != null and zombie.spriteFramesWalkingAccessory != null:
		zombieBlueprint.get_node("Walking/WalkingAccessory").frames = zombie.spriteFramesWalkingAccessory
		zombieBlueprint.get_node("Eating/EatingAccessory").frames = zombie.spriteFramesEatingAccessory
	createdZombie = zombieBlueprint

# METHODS

# Return the created Zombie as a Node2D
func getZombie() -> Node2D:
	return createdZombie
