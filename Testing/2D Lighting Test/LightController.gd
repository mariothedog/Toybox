extends Light2D

func _input(event):
	if Input.is_key_pressed(KEY_RIGHT):
		position.x += 2
	if Input.is_key_pressed(KEY_LEFT):
		position.x -= 2
	if Input.is_key_pressed(KEY_UP):
		position.y -= 2
	if Input.is_key_pressed(KEY_DOWN):
		position.y += 2
