extends Area2D

signal pie_collected

func _on_Pies_body_entered(body):
	$AnimationPlayer.play("pieBounce")
	if get_tree().current_scene.name == "Level1":
		get_node("/root/Level1").get_node("HUD")._on_Pies_pie_collected()
	elif get_tree().current_scene.name == "Level2":
		get_node("/root/Level2").get_node("HUD").get_node("HUD")._on_Pies_pie_collected()
	#emit_signal("pie_collected")
	set_collision_mask_bit(0,false)
	
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
