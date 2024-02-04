extends Camera2D

@export var zoom_camera : float = 1
@export var escala_baixo : float = 1.0
@export var escala_esquerda : float = 1.25
@export var escala_direita : float = 1.0
@export var offset_camera : Vector2 = Vector2(0,-150)
@export var smooth_camera : bool = true
@export var mapa_nivel : TileMap

func _ready():
	var rect_mapa = mapa_nivel.get_used_rect()
	var tamanho_tile = mapa_nivel.cell_quadrant_size
	var tamanho_mapa_pixel = rect_mapa.size * tamanho_tile
	limit_right = tamanho_mapa_pixel.x * escala_direita
	limit_left = -tamanho_mapa_pixel.x * escala_esquerda
	limit_bottom = tamanho_mapa_pixel.y * escala_baixo
	position_smoothing_enabled = smooth_camera
	camera(zoom_camera)
	print_debug(limit_right)
	print_debug(limit_left)
	print_debug(limit_bottom)

func camera(zoom):
	zoom = Vector2(zoom_camera, zoom_camera)
	$".".zoom = zoom
	$".".offset = offset_camera
