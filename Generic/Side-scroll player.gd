extends KinematicBody2D

# Movement exports
export var _SPEED = 300
export var _JUMP_SPEED = 500
export var _GRAVITY = 600

# Movement variables
var _velocity = Vector2()
var _jump = false

func _physics_process(delta):
	_get_input()
	_movement(delta)

func _get_input():
	var _horizontal_input_vel = 0
	if Input.is_action_pressed("right"):
		_horizontal_input_vel += 1
	if Input.is_action_pressed("left"):
		_horizontal_input_vel -= 1
	
	_velocity.x = _horizontal_input_vel * _SPEED
	
	_jump = false
	if Input.is_action_just_pressed("space"):
		_jump = true

func _movement(delta):
	_velocity.y += _GRAVITY * delta
	
	_velocity = move_and_slide(_velocity, Vector2.UP)
	
	if _jump and is_on_floor():
		_velocity.y = -_JUMP_SPEED
