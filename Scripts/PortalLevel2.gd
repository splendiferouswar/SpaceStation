extends Area2D

export(String, FILE, "*tscn") var world_scene
#var piesCollected = get_node("/root/Level1").get_node("HUD").Pies

func _ready():
	pass # Replace with function body.

func _process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Dag" && (get_node("/root/Level2").get_node("HUD").get_node("HUD").get_node("Pie").text != "3"):
			pass
			
		elif body.name == "Dag" && (get_node("/root/Level2").get_node("HUD").get_node("HUD").get_node("Pie").text == "3"):
			Globals.passedLevel1 = false
			get_tree().change_scene("res://Scene/YouWin.tscn")
	pass
