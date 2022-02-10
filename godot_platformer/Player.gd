#some of this setup referenced from this tutorial:
#https://docs.godotengine.org/en/stable/getting_started/step_by_step/your_first_game.html

extends Area2D

export var speed = 300
var screen_size
signal player_death
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	pass
	#commenting out old version of player character movement to move to kinematicbody2D version
	""""
	var vel = Vector2()
	#commands for moving
	if Input.is_action_pressed("ui_right"):
		$KinematicBody2D/AnimatedSprite.animation = "walk"
		vel.x += 1
	if Input.is_action_pressed("ui_left"):
		$KinematicBody2D/AnimatedSprite.animation = "walk"
		vel.x -= 1
	#commands for start and stop Bird Friend Deployment
	if Input.is_action_pressed("ui_up"):
		$KinematicBody2D/AnimatedSprite.animation = "armout"
		
	if vel.x < 0:
		$KinematicBody2D/AnimatedSprite.flip_h = true
	else:
		$KinematicBody2D/AnimatedSprite.flip_h = false
	
	vel = vel.normalized() * speed
	$KinematicBody2D/AnimatedSprite.play() 
	position += vel * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	"""


func _on_Area2D_area_entered(area):
	emit_signal("player_death")
	get_tree().quit()


func _on_Area2D_body_entered(body):
	emit_signal("player_death")
	get_tree().quit()
