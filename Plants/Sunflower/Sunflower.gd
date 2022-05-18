extends "res://Plants/GeneralPlant.gd"


var Sun: PackedScene = preload("res://GameObjects/Sun.tscn")

# Spawn a sun
func performAction() -> void:
	var sun: Node2D = Sun.instance()
	add_child(sun)
	sun.get_node("AnimationPlayer").play("Spawn")
