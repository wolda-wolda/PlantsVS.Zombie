extends Node

onready var main: Node2D = get_node("/root/Main")
onready var ui: CanvasLayer = main.get_node("UI")

var PlacementSystem = preload("res://Game/PlacementSystem.tscn")

var balance: int = 70 setget set_balance

signal changedBalance 

# ENUMS

enum mode {
	PLACE,
	REMOVE
}

enum fade {
	IN,
	OUT
}

func set_balance(value:int) -> void:
	balance = value
	main.get_node("UI/Economy/Balance").set_balance(value)
	emit_signal("changedBalance")
