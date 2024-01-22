extends ObjetoVivo
class_name VegetalPlayer

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

func gestor_grupos():
	add_to_group("Vegetal")
