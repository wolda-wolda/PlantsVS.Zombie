extends Node2D
# Spawns in suns at the top of the screen
# which slowly travel across the screen and can be collected


# RANDOM NUMBER GENERATOR
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

# SIGNAL METHODS

# Spawn a new sun at a random x position
func _on_Timer_timeout() -> void:
	var sunContainer: Node2D = Node2D.new()
	var sun: Node2D = Entities.Sun.instance()
	add_child(sunContainer)
	sunContainer.add_child(sun)
	sunContainer.global_position.x = 100 + rng.randi_range(-60, 60)
	sun.get_node("AnimationPlayer").play("Passive")
