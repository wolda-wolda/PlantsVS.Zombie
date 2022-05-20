extends Area2D
# Peashooter Projectile


# VARIABLES

var distance_travelled: float = 0.0

# ENGINE METHODS

# Makes the projectile travel across the screen
# Despawns when leaving the game area
func _process(delta: float) -> void:
	var speed: float = delta * 100
	position += Vector2(speed, 0)
	distance_travelled += speed
	if distance_travelled > 250:
		queue_free()

# Upon hitting a Zombie, damage and slow it
func _on_SnowPeashooterProjectile_area_entered(area: Area2D) -> void:
	area.get_parent().takeDamage(10)
	area.get_parent().slow(5)
	queue_free()
