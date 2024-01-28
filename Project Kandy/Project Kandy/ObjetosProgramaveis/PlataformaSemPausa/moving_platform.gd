extends Path2D

@onready var caminho : Path2D = $"."
@export var estatica : bool = false
@export var velocidade = 60
@export var escala_velocidade = 1
@export_range(0.0,1.0) var tempo : float = 0.0
@export var curva : Curve

@onready var seguir_caminho = $PathFollow2D
@onready var animacion = $AnimationPlayer

var direcao : int = 1

func _ready():
	if !estatica:
		curva.add_point(Vector2(1,1))
		escala_velocidade = 1.0 / (caminho.curve.get_baked_length() / velocidade)

func _physics_process(delta):
	if !estatica:
		tempo += delta * direcao * escala_velocidade
		if tempo >= 1.0:
			tempo = 1.0
			direcao = -1
		if tempo <= 0.0:
			tempo = 0.0
			direcao = 1
		seguir_caminho.progress_ratio = curva.sample(tempo)
