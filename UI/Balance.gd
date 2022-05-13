extends MarginContainer

func set_balance(value:int) -> void:
	get_node("HBoxContainer/Label").text = str(value)
