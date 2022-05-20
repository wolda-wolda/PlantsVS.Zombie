extends CenterContainer


export(String) var text

func _ready() -> void:
	$Label.text = text

func _on_Label_resized() -> void:
	$Label.rect_pivot_offset = $Label.rect_size / 2
	startAnimation()

func startAnimation() -> void:
	var tween: = Tween.new()
	tween.interpolate_property($Label, "rect_scale", Vector2(1,1), Vector2(5,5), 1, Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	add_child(tween)
	tween.start()
