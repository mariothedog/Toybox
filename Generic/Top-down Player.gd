extends KinematicBody2D

const SPEED = 200

var velocity = Vector2()

func _physics_process(_delta):
	_get_input()
	_movement()

func _get_input():
	var _input_vel = Vector2()
	if Input.is_action_pressed("left"):
		_input_vel.x -= 1
	if Input.is_action_pressed("right"):
		_input_vel.x += 1
	if Input.is_action_pressed("up"):
		_input_vel.y -= 1
	if Input.is_action_pressed("down"):
		_input_vel.y += 1
	velocity = _input_vel.normalized() * SPEED

func _movement():
	velocity = move_and_slide(velocity)
