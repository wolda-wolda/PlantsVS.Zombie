extends Node2D
# Node for spawning enemies
# Uses credits for deciding how many enemies will be spawned
# and how strong they will be


# EXPORT VARIABLES

export(int) var credits
export(int) var waveCredits

# ONREADY

onready var progressBar: TextureProgress = Global.GUI.get_node("ProgressBar")

# RANDOM NUMBER GENERATOR

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

# GAME VARIABLES

var initialWaveCredits: int = 0
var finalWaveCredits: int = 0
var zombieDeathCredits: int = 0
var spawnInterval = 7.0
var creditsSpent: int = 0
var waveCreditsSpent: int = 0
var zombies: Array = []

# SCENES

var genericZombie: Zombie = load("res://Zombies/GenericZombie/GenericZombie_Object.tres")

# ENGINE METHODS

# Loads the scripts of all the Zombies from a directory
func _ready() -> void:
	progressBar.hide()
	initialWaveCredits = credits
	finalWaveCredits = credits + waveCredits
	rng.randomize()
	for x in Directories.getEntities(Directories.dirZombies):
		zombies.push_back(load(x))
	progressBar.setMax(credits + waveCredits)

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
		zombieBlueprint.connect("on_death", self, "_onZombieDeath", [], CONNECT_ONESHOT)
		zombieBlueprint.global_position = Vector2(230, 16 * rng.randi_range(1, 5) - 8)
		Global.main.get_node("Zombies").add_child(zombieBlueprint)
		waveCredits -= zombieBlueprint.cost
		waveCreditsSpent += zombieBlueprint.cost
		$GamePhase.start(spawnInterval + rng.randi_range(-3, 3))
		yield(get_tree().create_timer(0.5), "timeout")
		zombieCreator.queue_free()

# SIGNAL METHODS

# Starts the timer with a random value for spawning enemies
func _on_PregamePhase_timeout() -> void:
	progressBar.show()
	$GamePhase.start(0.1)

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
		zombieBlueprint.connect("on_death", self, "_onZombieDeath", [], CONNECT_ONESHOT)
		zombieBlueprint.global_position = Vector2(230, 16 * rng.randi_range(1, 5) - 8)
		Global.main.get_node("Zombies").add_child(zombieBlueprint)
		credits -= zombieBlueprint.cost
		creditsSpent += zombieBlueprint.cost
		$GamePhase.start(spawnInterval + rng.randi_range(-3, 3))
		zombieCreator.queue_free()
	else:
		$GamePhase.paused = true

# Gets executed when a zombie dies
# Used for updating the progress bar
# and displaying animations
func _onZombieDeath(cost: int) -> void:
	progressBar.setValue(progressBar.getValue() + cost)
	zombieDeathCredits += cost
	
	if zombieDeathCredits >= initialWaveCredits:
		if zombieDeathCredits == finalWaveCredits:
			var textAnimation = Entities.TextAnimation.instance()
			textAnimation.text = "You win!"
			Global.UI.add_child(textAnimation)
			return
		finalWave()
