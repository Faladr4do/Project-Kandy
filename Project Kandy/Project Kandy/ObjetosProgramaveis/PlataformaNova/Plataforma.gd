extends AnimatableBody2D

@export var distancia : Vector2
@export var tempo_deslocacao : float = 6.0
@export_range(0.0, 1.0) var phase_offset : float

var pivo : Vector2
var tempo : float

func _ready():
	pivo = global_position

func buscar_posicao(t : float):
	var x = pivo.x + cos(TAU * (t + phase_offset)) * distancia.x
	var y = pivo.y + sin(TAU * t) * distancia.y
	return Vector2(x, y)

func _physics_process(delta):
	tempo = fmod(tempo + delta/tempo_deslocacao, 1.0)
	global_position = buscar_posicao(tempo)
