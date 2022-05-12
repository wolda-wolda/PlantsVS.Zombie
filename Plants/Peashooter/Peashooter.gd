extends "res://Plants/GeneralPlant.gd"


var Projectile: PackedScene = preload("res://Projectiles/Projectiles.tscn")

# Shoot a projectile
func performAction() -> void:
	if $EnemyDetection.is_colliding():
		var projectile = Projectile.instance()
		add_child(projectile)
