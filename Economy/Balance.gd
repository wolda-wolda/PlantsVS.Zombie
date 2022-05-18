extends MarginContainer
# handles the balance along with its UI


# ENGINE METHODS

# Sets the balance to the starting balance
func _ready() -> void:
	setBalance(Global.balance)

# SETTERS

# Sets the balance on the UI
func setBalance(amount: int) -> void:
	$HBoxContainer/Label.text = str(amount)
