extends "res://Generic/Side-scroll player.gd"

# Slow-mo constants
const END_VALUE = 1

# Slow-mo variables
var slow_mo_enabled = false
var slow_mo_fade_out = false
var time_start
var duration_ms
var start_value

func _ready():
	Engine.time_scale = 1

func _process(_delta):
	if slow_mo_fade_out:
		var current_time = OS.get_ticks_msec() - time_start
		var time_scale = circ_ease_in(current_time, start_value, END_VALUE, duration_ms)
		if current_time >= duration_ms:
			slow_mo_fade_out = false
			time_scale = END_VALUE
			print(" ")
		Engine.time_scale = time_scale

func get_additional_input():
	if Input.is_action_pressed("left_click"):
		start_slow_mo()
	else:
		if slow_mo_enabled:
			stop_slow_mo(0.2)

func start_slow_mo(start_strength = 0.9):
	start_value = 1 - start_strength
	Engine.time_scale = start_value
	slow_mo_enabled = true

func stop_slow_mo(duration = 0.4):
	# The duration refers to how long the fade lasts.
	time_start = OS.get_ticks_msec()
	duration_ms = duration * 1000
	slow_mo_enabled = false
	slow_mo_fade_out = true

# t: current time
# b: start value
# c: end value
# d: duration
func circ_ease_in(t, b, c, d): # Tween is affected by Engine.time_scale so the easing has to be done manually.
	# http://gizma.com/easing/
	t /= d
	return -c * (sqrt(1 - t * t) - 1 ) + b
