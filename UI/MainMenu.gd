extends CenterContainer



func _on_Play_pressed():
	$VBoxContainer/Play.visible = false
	$VBoxContainer/MultiPlayer.visible = true
	$VBoxContainer/SinglePlayer.visible = true


func _on_Exit_pressed():
	get_tree().quit()


func _on_SinglePlayer_pressed():
	pass # Replace with function body.
