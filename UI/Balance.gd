extends MarginContainer


func _ready() -> void:
	set_balance(Global.balance)

func set_balance(value: int) -> void:
	get_node("HBoxContainer/Label").text = str(value)
