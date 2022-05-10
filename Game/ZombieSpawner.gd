extends Node2D

var Zombie:PackedScene = preload("res://Zombie/Zombie.tscn")
var rng: = RandomNumberGenerator.new()

func _on_Timer_timeout() -> void:
	var zombie:Node2D = Zombie.instance()
	zombie.position = global_position
	zombie.position.y += rng.randi_range(-100, 100)
	get_node("/root/Main/YSort").add_child(zombie)
