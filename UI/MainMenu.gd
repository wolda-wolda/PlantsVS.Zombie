extends CenterContainer



func _on_Play_pressed():
	$VBoxContainer/Play.visible = false
	$VBoxContainer/MultiPlayer.visible = true
	$VBoxContainer/SinglePlayer.visible = true

func _on_Exit_pressed():
	get_tree().quit()

func _on_SinglePlayer_pressed():
	var mainlevel: Node2D = Entities.MainLevel.instance()
	mainlevel.name = "MainLevel"
	Global.main.add_child(mainlevel)
