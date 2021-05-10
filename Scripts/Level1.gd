extends Node


func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == "Dag":
		$FadeInEffect.play("Fade in")
		get_node("/root/Level1").get_node("Nebulae").get_node("Area2D").get_node("FadeInEffect").get_node("pillars_of_creation").visible = true
		get_node("/root/Level1").get_node("Nebulae").get_node("Area2D").get_node("FadeInEffect").get_node("Crab Nebula").visible = true
	else:
		get_node("/root/Level1").get_node("Nebulae").get_node("Area2D").get_node("FadeInEffect").get_node("pillars_of_creation").visible = false
		get_node("/root/Level1").get_node("Nebulae").get_node("Area2D").get_node("FadeInEffect").get_node("Crab Nebula").visible = false


func _on_Area2D_body_exited(body):
	if body.name == "Dag":
		$FadeInEffect.play_backwards("Fade in")
		#get_node("/root/Level1").get_node("Nebulae").get_node("Area2D").get_node("FadeInEffect").get_node("pillars_of_creation").visible = false
		#get_node("/root/Level1").get_node("Nebulae").get_node("Area2D").get_node("FadeInEffect").get_node("Crab Nebula").visible = false
