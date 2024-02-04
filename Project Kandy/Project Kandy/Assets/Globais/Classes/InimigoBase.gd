extends ObjetoVivo
class_name InimigoBase

@export var alvo : Area2D
@export var chao_detect : RayCast2D

func gestor_grupos():
	add_to_group("Inimigo")
