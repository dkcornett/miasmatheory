extends KinematicBody2D

#began with following this tutorial:
#https://docs.godotengine.org/en/stable/tutorials/physics/kinematic_character_2d.html#moving-the-kinematic-character

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const GRAVITY = 400.0
export var WALK_SPEED = 200
export var JUMP_FORCE = 200.0

export(PackedScene) var crow_scene

signal useFamiliar

var vel = Vector2()
var familiarOut = false

#movement and ability bools
"""
the wasPointing variable (implied bool) determines what the last x-axis input was.
all sprites will be flipped when after a "ui_left" until the next "ui_right"
"""
var wasPointing = false
var canMove = true
var canJump = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	#process inputs and decide AnimatedSprite accordingly
	if canMove:
		if Input.is_action_pressed("ui_accept") && canJump:
		#jump! make an animation for this!
			vel.y = -JUMP_FORCE
			$JumpTimer.start()
			canJump = false
		else:
			#fall due to gravity. make an animation for this!
			vel.y += delta * GRAVITY
		if Input.is_action_pressed("ui_left"):
			vel.x = -WALK_SPEED
			wasPointing = true
			$AnimatedSprite.animation = "walk"
		elif Input.is_action_pressed("ui_right"):
			vel.x = WALK_SPEED
			wasPointing = false
			$AnimatedSprite.animation = "walk"
		else:
			vel.x = 0
	
		if Input.is_action_pressed("ui_up"):
			if(!familiarOut):
				$AnimatedSprite.animation = "armout"
				_on_summon_Familiar()
			else:
				$Camera2D.current = true
				canMove = true
				familiarOut = false
				
	
		if wasPointing:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
	
		#move
		move_and_slide(vel, Vector2(0, -1))
	
		#camera follow?
		$Camera2D.get_position_in_parent()
		
		$AnimatedSprite.play()
		
	else:
		if(Input.is_action_pressed("ui_accept")):
			canMove = true;
			$Camera2D.current = true


func _on_JumpTimer_timeout():
	canJump = true
	
func _on_summon_Familiar():
	$Camera2D.current = false
	canMove = false
	var crow = crow_scene.instance()
	add_child(crow)
	familiarOut = true
	crow.position = $crowSpawnPoint.position
	emit_signal("useFamiliar")

