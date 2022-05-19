extends Node2D
# Node for spawning enemies
# Uses credits for deciding how many enemies will be spawned
# and how strong they will be


# EXPORT VARIABLES

export(int) var credits
export(int) var waveCredits

# RANDOM NUMBER GENERATOR
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

# GAME VARIABLES
var spawnInterval = 7.0
var creditsSpent: int = 0
var waveCreditsSpent: int = 0
var zombies: Array = []

# SCENES
var genericZombie: Zombie = load("res://Zombies/GenericZombie/GenericZombie_Object.tres")

# ENGINE METHODS

# Loads the scripts of all the Zombies from a directory
func _ready() -> void:
	rng.randomize()
	for x in Directories.getEntities(Directories.dirZombies):
		zombies.push_back(load(x))

# METHODS

# Starts the final wave
# Spawns enemies
func finalWave() -> void:
	while waveCredits > 0:
		var zombieCreator: ZombieCreator
		if waveCreditsSpent > 50:
			zombieCreator= ZombieCreator.new(zombies[rng.randi_range(0, zombies.size() - 1)])
		else:
			zombieCreator = ZombieCreator.new(genericZombie)
		var zombieBlueprint: Node2D = zombieCreator.getZombie()
		zombieBlueprint.position = Vector2(220, 16 * rng.randi_range(2, 6) + 8)
		get_parent().get_node("Zombies").add_child(zombieBlueprint)
		waveCredits -= zombieBlueprint.cost
		waveCreditsSpent += zombieBlueprint.cost
		$GamePhase.start(spawnInterval + rng.randi_range(-3, 3))
		yield(get_tree().create_timer(0.5), "timeout")
		zombieCreator.queue_free()

# SIGNAL METHODS

# Starts the timer with a random value for spawning enemies
func _on_PregamePhase_timeout() -> void:
	$GamePhase.start(spawnInterval + rng.randi_range(-3, 3))

# Spawns a new enemy
# Starts the final wave when credits run out
func _on_GamePhase_timeout() -> void:
	if credits > 0:
		var zombieCreator: ZombieCreator
		if creditsSpent > 50:
			zombieCreator= ZombieCreator.new(zombies[rng.randi_range(0, zombies.size() - 1)])
		else:
			zombieCreator = ZombieCreator.new(genericZombie)
		var zombieBlueprint: Node2D = zombieCreator.getZombie()
		zombieBlueprint.position = Vector2(220, 16 * rng.randi_range(2, 6) + 8)
		get_parent().get_node("Zombies").add_child(zombieBlueprint)
		credits -= zombieBlueprint.cost
		creditsSpent += zombieBlueprint.cost
		$GamePhase.start(spawnInterval + rng.randi_range(-3, 3))
		zombieCreator.queue_free()
	else:
		$GamePhase.paused = true
		finalWave()
