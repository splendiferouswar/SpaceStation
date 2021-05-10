extends Area2D


func die() -> void:
	queue_free()
	
	
func _on_SidesChecker_body_entered(body):
	if body:
		queue_free()
