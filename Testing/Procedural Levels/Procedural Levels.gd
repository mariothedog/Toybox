tool
extends Node2D

const WIDTH = 100
const HEIGHT = 100

const TILES = {
	"grass" : 0,
	"rock" : 1,
	"sand" : 2
}

export (int, 1, 9) var octaves = 3 setget _set_octave
export (float, 0.1, 256) var period = 15 setget _set_period
export (float, 0, 1) var persistence = 0.75 setget _set_persistence
export (float, 0.1, 4) var lacunarity = 1.5 setget _set_lacunarity

var open_simplex_noise

func _set_octave(value):
	octaves = value
	_generate_new_world()
func _set_period(value):
	period = value
	_generate_new_world()
func _set_persistence(value):
	persistence = value
	_generate_new_world()
func _set_lacunarity(value):
	lacunarity = value
	_generate_new_world()

func _create_noise():
	randomize()
	open_simplex_noise = OpenSimplexNoise.new()
	open_simplex_noise.seed = randi()
	
	open_simplex_noise.octaves = octaves
	open_simplex_noise.period = period
	open_simplex_noise.persistence = persistence
	open_simplex_noise.lacunarity = lacunarity
	
	#var noise_texture = NoiseTexture.new()
	#noise_texture.noise = open_simplex_noise
	#$Sprite.texture = noise_texture

func _generate_world():
	if has_node("TileMap"):
		for x in WIDTH:
			for y in HEIGHT:
				var pos = Vector2(x - WIDTH / 2.0, y - HEIGHT / 2.0)
				var tile = _get_tile_index(open_simplex_noise.get_noise_2d(float(x), float(y)))
				$TileMap.set_cellv(pos, tile)
		#$TileMap.update_bitmask_region()

func _generate_new_world():
	_create_noise()
	_generate_world()

func _get_tile_index(noise_sample):
	if noise_sample < -0.1:
		return TILES.sand
	if noise_sample < 0.1:
		return TILES.rock
	return TILES.grass

func _process(_delta):
	if Engine.editor_hint and Input.is_action_just_pressed("ui_accept"):
		_generate_new_world()
