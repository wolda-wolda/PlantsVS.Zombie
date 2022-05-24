extends TextureProgress


func getValue() -> float:
	return value

func setValue(newValue : int) -> void:
	value = newValue

func setMax(newMax: int)  -> void:
	max_value = newMax
