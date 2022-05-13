extends Node2D



func _on_Button_pressed() -> void:
	Global.balance += 25
	queue_free()
