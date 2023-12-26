extends Path2D

var dano = Global.dano_obstaculo

@export var loop = true
@export var velocidade = 60
@export var escala_vel = 1

@onready var caminho = $PathFollow2D
@onready var area_serra = $AnimatableBody2D/Area2D

func _ready():
	area_serra.add_to_group("Obstaculo")

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("Vegetal"):
		body.dano(dano)
