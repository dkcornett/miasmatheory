extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var FLY_SPEED = 20

var vel = Vector2()
var wasPointingRight = false
var wasPointingDown = false

signal returnFamiliar
# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.current = true
	connect("returnFamiliar", find_parent("Player/PlayerKinematicBody2D"), "_on_return_Familiar")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#determine which direction to fly the bird in
	if Input.is_action_pressed("ui_right"):
		vel.x += FLY_SPEED
		wasPointingRight = false
	if Input.is_action_pressed("ui_left"):
		vel.x -= FLY_SPEED
		wasPointingRight = true
	if Input.is_action_pressed("ui_up"):
		vel.y -= FLY_SPEED
		wasPointingDown = false
	if Input.is_action_pressed("ui_down"):
		vel.y += FLY_SPEED
		wasPointingDown = true
	if Input.is_action_pressed("ui_select"):
		emit_signal("returnFamiliar")
		$Camera2D.current = false
		queue_free()
	
	
	#determine which way to point the bird
	if(wasPointingRight):
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false

		
	#move
	#move
	move_and_slide(vel, Vector2(0, -1))
#	vel = vel.normalized() * FLY_SPEED
#	position += vel*delta
	
	#camera follow?
	$Camera2D.get_position_in_parent()
	
	$AnimatedSprite.play()
