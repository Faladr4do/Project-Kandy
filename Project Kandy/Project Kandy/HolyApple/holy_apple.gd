extends CharacterBody2D

@onready var you_won = "res://Project Kandy/Menus/menu_index.tscn"
@export var area_interacao : AreaInteragir

func _ready():
	area_interacao.interagir = Callable(self, "inter_act")

func inter_act():
	TransicaoNivel.transicao()
	await TransicaoNivel.acabou_transicao
	Checkpoint.ultima_posicao = null
	Checkpoint.nivel_atual = null
	Checkpoint.moedas_coletadas = null
	get_tree().change_scene_to_file(you_won)
