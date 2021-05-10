extends Area2D

signal coin_collected

func _on_Coin_body_entered(body):
	$AnimationPlayer.play("Bounce")
	if get_tree().current_scene.name == "Level1":
		get_node("/root/Level1").get_node("HUD")._on_Coin_coin_collected()
	elif get_tree().current_scene.name == "Level2":
		get_node("/root/Level2").get_node("HUD").get_node("HUD")._on_Coin_coin_collected()
	#emit_signal("coin_collected")
	set_collision_mask_bit(0,false)
	$SoundCoinCollect.play()
	
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
