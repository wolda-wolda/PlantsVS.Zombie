extends "res://Plants/GeneralPlant.gd"


var Sun: PackedScene = null

# Spawn a sun
func performAction() -> void:
	var sun: Node2D = Sun.instance()
	add_child(sun)
	sun.get_node("AnimationPlayer").play("Spawn")
