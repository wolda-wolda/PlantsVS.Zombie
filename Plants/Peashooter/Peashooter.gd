extends "res://Plants/GeneralPlant.gd"


# Shoot a projectile
func performAction() -> void:
	if $EnemyDetection.is_colliding():
		var projectile = Entities.PeashooterProjectile.instance()
		add_child(projectile)
