extends Button


func _on_PlayButton_pressed():
	if Globals.passedLevel1 == false:
		get_tree().change_scene("res://Scene/Level1.tscn")
	elif Globals.passedLevel1 == true:
		get_tree().change_scene("res://Scene/Level2.tscn")
