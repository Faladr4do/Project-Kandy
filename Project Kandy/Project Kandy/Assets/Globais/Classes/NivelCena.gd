extends Node
class_name NivelCena

@export var jogador : CharacterBody2D

func _ready():
	if !jogador:
		jogador = buscar_jogador("VegetalPlayer")
	else:
		jogador.vida_total = Checkpoint.vida_total
		Global.moedas_coletadas = Checkpoint.moedas_coletadas

func _enter_tree():
	Checkpoint.moedas_coletadas = Global.moedas_coletadas
	if Checkpoint.ultima_posicao and Checkpoint.nivel_atual:
		jogador.global_position = Checkpoint.ultima_posicao

func buscar_jogador(nome_classe):
	var all_children = get_children()
	for classe : Node in all_children:
		if classe.is_class(nome_classe):
			print_debug(classe)
			return classe

func _process(delta):
	#print_debug(get_tree().set_currentscene())
	get_tree().set_current_scene(get_parent())
	if jogador:
		verificar_vida_player()
	else:
		buscar_jogador("VegetalPlayer")

func verificar_vida_player():
	if jogador.vida_total < 0:
		game_over()

func game_over():
	jogador.vida_total = Global.vidas_max
	Global.moedas_coletadas = Checkpoint.moedas_coletadas
	get_tree().reload_current_scene()
