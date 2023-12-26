extends Path2D

@export var loop = true
@export var velocidade = 60
@export var escala_vel = 1

@onready var caminho = $PathFollow2D
@onready var area_serra = $AnimatableBody2D/Area2D

func _ready():
	area_serra.add_to_group("Obstaculo")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
