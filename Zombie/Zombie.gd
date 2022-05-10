extends Node2D

var movementSpeed:float=-10.0
var hp:int=100

func _process(delta: float) -> void:
	position.x += movementSpeed * delta


func _on_Area2D_area_entered(area: Area2D) -> void:
	hp -= 10
	
	if hp<=0:
		queue_free()
