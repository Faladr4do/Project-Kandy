extends Path2D

var dano_obstaculo = Global.dano_obstaculo
var forca_knockback = 100
var cortou = false


@export var loop = true
@export var velocidade = 60
@export var escala_vel = 1

@onready var caminho = $PathFollow2D
@onready var area_serra = $AnimatableBody2D/Area2D

func _ready():
	area_serra.add_to_group("Obstaculo")

func _process(delta):
	if cortou:
		velocidade = velocidade * -1
		cortou = false

func _on_area_2d_body_entered(body):
	if body.has_method("dano"):
		var ataque = Ataque.new()
		ataque.dano_ataque = dano_obstaculo
		ataque.forca_knockback = forca_knockback
		ataque.posicao_ataque = global_position
		body.dano(ataque)
