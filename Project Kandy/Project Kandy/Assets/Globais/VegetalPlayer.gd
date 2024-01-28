extends ObjetoVivo
class_name VegetalPlayer

@export var zoom_camera : float = 1.0
@export var tempo_coyote : Timer
@export var estigar_cooldown : Timer
@export var fire : PackedScene = preload("res://Project Kandy/Projeteis/fireball.tscn")

var doubleJump = false
var lentoTempo = false
var estaAtacar = false
var cooldown = false
var speed = 1
var pode_saltar : bool = false

func _process(delta):
	gestor_grupos()
	camera(zoom_camera)

func gestor_grupos():
	add_to_group("Vegetal")

func camera(zoom):
	zoom = Vector2(zoom_camera, zoom_camera)
	$Camera2D.zoom = zoom
