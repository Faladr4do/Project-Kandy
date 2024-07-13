extends Area2D

const FICHEIRO_INI = "res://Project Kandy/Niveis/nivel_"
const FICHEIRO_FIN = ".tscn"

@export var area_nivel : CollisionShape2D

var nivel_atual
var numero_nivel
var nivel_alvo

func _ready():
	nivel_atual = str(get_parent().get_parent()).split(":")[0]
	print_debug(nivel_atual)
	numero_nivel = nivel_atual.to_int()
	nivel_alvo = FICHEIRO_INI + str(numero_nivel+1) + FICHEIRO_FIN
	print_debug(nivel_alvo)

func _on_body_entered(body):
	if body.is_in_group("Vegetal"):
		body.velocidade *= 0
		TransicaoNivel.transicao()
		await TransicaoNivel.acabou_transicao
		#get_tree().change_scene_to_file(nivel_alvo)
		var gestor = get_parent().get_parent().get_parent()
		print_debug(gestor)
		print_debug(gestor.get_class())
		Checkpoint.nivel_atual = nivel_alvo
		Checkpoint.ultima_posicao = null
		Checkpoint.moedas_coletadas = Global.moedas_coletadas
		Checkpoint.vida_total = body.vida_total
		if gestor.is_class("Node") and nivel_alvo:
			gestor.mudar_nivel(nivel_alvo)
		else:
			get_tree().quit()
