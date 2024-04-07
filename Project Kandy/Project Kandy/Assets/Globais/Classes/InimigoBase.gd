extends ObjetoVivo
class_name InimigoBase

@export var alvo : Area2D
@export var chao_detect : RayCast2D
@export var capacete : PackedScene

@onready var ponto_capacete : Marker2D = $PontoCapacete

var capacete_colocado : Sprite2D
var capacete_destruido : bool = false

func gestor_grupos():
	add_to_group("Inimigo")

func colocar_capacete():
	if capacete:
		var colocar_capacete = capacete.instantiate()
		capacete_colocado = colocar_capacete
		add_child(colocar_capacete)
		colocar_capacete.global_position = ponto_capacete.global_position

func destruir_capacete():
	if vida_total == 0 and (capacete_colocado and !capacete_destruido):
		capacete_colocado.destruido = true
		capacete_colocado.cair = gravity
		capacete_destruido = true
