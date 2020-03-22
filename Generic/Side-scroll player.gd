extends KinematicBody2D

# Movement exports
export var SPEED = 300
export var JUMP_SPEED = 500
export var GRAVITY = 600

# Movement variables
var velocity = Vector2()
var jump = false

func _physics_process(delta):
	get_input()
	get_additional_input()
	movement(delta)

func get_input():
	var horizontal_input_vel = 0
	if Input.is_action_pressed("right"):
		horizontal_input_vel += 1
	if Input.is_action_pressed("left"):
		horizontal_input_vel -= 1
	
	velocity.x = horizontal_input_vel * SPEED
	
	jump = false
	if Input.is_action_just_pressed("up"):
		jump = true

func get_additional_input():
	pass

func movement(delta):
	velocity.y += GRAVITY * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if jump and is_on_floor():
		velocity.y = -JUMP_SPEED
