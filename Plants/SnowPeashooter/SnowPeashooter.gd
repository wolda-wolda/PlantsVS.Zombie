extends "res://Plants/GeneralPlant.gd"


# Shoot a projectile
func performAction() -> void:
	if $EnemyDetection.is_colliding():
		var projectile = Entities.SnowPeashooterProjectile.instance()
		add_child(projectile)
