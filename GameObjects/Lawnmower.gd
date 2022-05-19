extends Node2D

var movementSpeed:float = 100.0

func _process(delta: float) -> void:
	position.x += movementSpeed * delta
	
func _ready() -> void:
	set_process(false)


func _on_HitHurtbox_area_entered(area: Area2D) -> void:
	set_process(true)
