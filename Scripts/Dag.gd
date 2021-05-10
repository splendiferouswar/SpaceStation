extends KinematicBody2D

const SPEED = 180
const JUMPFORCE = -800
var GRAVITY = 30
const WEIGHTFORLINEARSTOPPING = 0.7
export var ladder_on = false

var shoot_bool : bool = true

onready var	raycast2d := $RayCast2D
onready var vfx_line := $vfx_line



var coins = 0

var velocity = Vector2(0,0)

func _physics_process(_delta): 
	#header
	#every code here will be run 60 fps
	
		
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Sprite.play("Run")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.play("Run")
		$Sprite.flip_h = true
	else:
		$Sprite.play("Idle")
		
	velocity.y = velocity.y + GRAVITY
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = JUMPFORCE
			
	else:
		if velocity.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
	
	if Input.is_action_just_pressed("jump") and is_on_floor(): #just pressed prevents holding key to jump indefinately 
		velocity.y = JUMPFORCE
		$SoundJump.play()
		
	
	velocity = move_and_slide(velocity, Vector2.UP) #second parameter tells godot up id up
	
	velocity.x = lerp(velocity.x, 0 , WEIGHTFORLINEARSTOPPING) #linear interpolation 

	if ladder_on == true:
		GRAVITY = 0
		if Input.is_action_pressed("ui_up"):
			velocity.y = -SPEED
		elif Input.is_action_pressed("ui_down"):
			velocity.y = SPEED
		else:
			velocity.y = 0
	else:
		GRAVITY = 35
		
	raycast_bullet_stuff()
	
		
func add_coin():
	coins += 1

func ouch(var enemyPosx):
	set_modulate(Color(1,0.3,0.3,0.3))
	velocity.y = JUMPFORCE * 0.5
	
	if position. x < enemyPosx:
		velocity.x = -900
	elif position. x > enemyPosx:
		velocity.x = 900
	$Timer.start()
	
	
func raycast_bullet_stuff() -> void:
	var mouse_pos := get_global_mouse_position()
	var angle_from_mouse_to_player := (mouse_pos.angle_to_point(global_position)) * (180/PI)
	raycast2d.rotation_degrees = (angle_from_mouse_to_player - 90) #- 
	#print(angle_from_mouse_to_player)
	
	if raycast2d.is_colliding() and Input.is_action_pressed("shoot") and shoot_bool == true:
		$Sprite.play("Shoot")
			
		make_line()
		make_particles()
		check_if_we_can_kill_enemy()
#	Add this line as well
	elif Input.is_action_just_released("shoot"):
		reset_line()


func reset_line() -> void:
	vfx_line.points[1] = Vector2.ZERO


func make_line() -> void:
	vfx_line.points[1] = transform.xform_inv(raycast2d.get_collision_point())


func make_particles() -> void:
	var hit_particles := preload("res://Scene/hit_particles.tscn").instance()
	hit_particles.emitting = true
	hit_particles.global_position = raycast2d.get_collision_point()
	get_parent().add_child(hit_particles)


func check_if_we_can_kill_enemy() -> void:
	#print(raycast2d.get_collider_shape())   # We need to print this line to 
#	understand the first if statment

	if raycast2d.get_collider_shape() == 0:
		if raycast2d.get_collider().has_method("die"):
			raycast2d.get_collider().die()
			
#			print("we have a hit") - now celebrate!

func _on_Timer_timeout():
	get_tree().change_scene("res://Scene/YouLoose.tscn")
	

func _on_Pies_pie_collected():
	pass # Replace with function body.
