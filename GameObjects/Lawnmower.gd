extends Node2D
# Lawnmower which activates when Zombies reach the far left of the map
# Kills all Zombies on its way to the right and disappears after that

# VARIABLES
var distance_travelled: float = 0.0

# ENGINE METHODS

# Deactivates the _process method
func _ready() -> void:
	set_process(false)

# Makes the lawnmower move to the right
# Frees itself when it travels outside of the playing area
func _process(delta: float) -> void:
	var speed: float = delta * 100
	position += Vector2(speed, 0)
	distance_travelled += speed
	if distance_travelled > 250:
		queue_free()

# SIGNAL METHODS

# When a Zombie enters the area, start moving and start shaking animation
# Damage Zombies upon entering the area
func _on_Area2D_area_entered(area: Area2D) -> void:
	set_process(true)
	area.get_parent().takeDamage(1000)
	$AnimationPlayer.play("Shake")
