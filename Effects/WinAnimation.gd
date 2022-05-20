extends CenterContainer


func _ready() -> void:
	var tween: = Tween.new()
	tween.interpolate_property($Label, "rect_scale", Vector2(1,1), Vector2(5,5), 1, Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	add_child(tween)
	tween.start()
