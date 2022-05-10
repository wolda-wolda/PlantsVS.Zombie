extends Area2D

var movementSpeed:float=100

func _process(delta: float) -> void:
	position.x += movementSpeed * delta


func _on_Projectile_area_entered(area: Area2D) -> void:
	queue_free()
