extends Node2D

var projectile=preload("res://Projectiles/Projectiles.tscn")

func shoot() -> void:
	var p = projectile.instance()
	add_child(p)
	
func _on_Timer_timeout() -> void:
	if $RayCast2D.is_colliding():
		shoot()
