extends Node

onready var main: Node2D = get_node("/root/Main")
onready var ui: CanvasLayer = main.get_node("UI")
var balance:int = 100 setget set_balance

func set_balance(value:int):
	balance = value
	main.get_node("UI/Balance").set_balance(value)
