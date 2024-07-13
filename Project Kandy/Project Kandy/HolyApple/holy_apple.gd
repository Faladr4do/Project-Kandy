extends CharacterBody2D

@export var you_won : PackedScene
@export var area_interacao : AreaInteragir

func _ready():
	area_interacao.interagir = Callable(self, "inter_act")

func inter_act():
	TransicaoNivel.transicao()
	await TransicaoNivel.acabou_transicao
	Checkpoint.ultima_posicao = null
	Checkpoint.nivel_atual = null
	Checkpoint.moedas_coletadas = null
	get_tree().change_scene_to_packed(you_won)
