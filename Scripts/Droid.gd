extends KinematicBody2D

var velocity = Vector2()
var speed = 50
export var direction = 1 #left
export var detectsCliffs = true


func _ready():
	
	if direction == 1:
		$AnimatedSprite.flip_h = false
	
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$FloorChecker.enabled = detectsCliffs
	if detectsCliffs:
		set_modulate(Color(1,0.8,1))
	
	
func _physics_process(delta):
	if is_on_wall() or not $FloorChecker.is_colliding() and detectsCliffs and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	velocity.y += 20
	
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)
	


func _on_SidesChecker_body_entered(body):
	if body.name == "Dag":
		$Timer.start()
		body.ouch(position.x)
	pass

func die() -> void:
	speed = 0
	set_collision_mask_bit(0,false)
	$AnimatedSprite.playing = false
	$AnimatedSprite.modulate = (100)
	
	
	var t = Timer.new()
	t.set_wait_time(0.25)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	_on_Timer_timeout()
	
	t.queue_free()

func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
