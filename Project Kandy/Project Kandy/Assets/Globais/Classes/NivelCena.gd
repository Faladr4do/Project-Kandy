extends Node
class_name NivelCena

@export var jogador : CharacterBody2D

func _ready():
	if !jogador:
		jogador = buscar_jogador("VegetalPlayer")

func _enter_tree():
	if Checkpoint.ultima_posicao:
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
	print_debug(jogador)
	if jogador:
		verificar_vida_player()
	else:
		buscar_jogador("VegetalPlayer")

func verificar_vida_player():
	if jogador.vida_total < 0:
		game_over()

func game_over():
	jogador.vida_total = Global.vidas_max
	get_tree().reload_current_scene()
