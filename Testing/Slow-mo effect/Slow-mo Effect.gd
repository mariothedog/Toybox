extends Node2D

# The player has a z-index of 1 so it is not affected by the shader.

var chromatic_aberration_amount = 0
var blur_amount = 0

func _process(_delta):
	if $Player.slow_mo_enabled:
		if $Player.slow_mo_fade_out:
			chromatic_aberration_amount = lerp(chromatic_aberration_amount, 0, 0.03)
			blur_amount = lerp(blur_amount, 0, 0.03)
		else:
			chromatic_aberration_amount = lerp(chromatic_aberration_amount, clamp($Player.velocity.length()/100, 1, 5), 0.01)
			blur_amount = lerp(blur_amount, clamp($Player.velocity.length()/300, 0.2, 2), 0.01)
		$Effect.material.set_shader_param("amount", chromatic_aberration_amount)
		$Effect.material.set_shader_param("blur_amount", blur_amount)

func _on_Player_slow_mo_enabled():
	$Effect.material.set_shader_param("apply", true)

func _on_Player_slow_mo_disabled():
	$Effect.material.set_shader_param("apply", false)
