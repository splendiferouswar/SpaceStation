extends Area2D


func _ready():
	pass


func _on_Ladder_body_entered(body):
	if body.name == "Dag":
		get_node("/root/Level2").get_node("Dag").get_node("Dag").ladder_on = true


func _on_Ladder_body_exited(body):
	if body.name == "Dag":
			get_node("/root/Level2").get_node("Dag").get_node("Dag").ladder_on = false
