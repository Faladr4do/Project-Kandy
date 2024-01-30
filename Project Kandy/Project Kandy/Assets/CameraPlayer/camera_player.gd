extends Camera2D

@export var zoom_camera : float = 1
@export var offset_camera : Vector2 = Vector2(0,-100)
@export var smooth_camera : bool = true
@export var mapa_nivel : TileMap

func _ready():
	var rect_mapa = mapa_nivel.get_used_rect()
	var tamanho_tile = mapa_nivel.cell_quadrant_size
	var tamanho_mapa_pixel = rect_mapa.size * tamanho_tile
	limit_right = tamanho_mapa_pixel.x
	limit_bottom = tamanho_mapa_pixel.y
	position_smoothing_enabled = smooth_camera
	camera(zoom_camera)

func camera(zoom):
	zoom = Vector2(zoom_camera, zoom_camera)
	$".".zoom = zoom
