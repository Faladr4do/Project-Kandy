extends Node
class_name GestorJogo

signal pausar_jogo(is_paused)

var nivel_velho
var nivel
var prox_nivel
var jogador

var loading : bool = false

var jogo_pausado = false:
	get:
		return jogo_pausado
	set(valor):
		jogo_pausado = valor
		get_tree().paused = jogo_pausado
		emit_signal("pausar_jogo", jogo_pausado)

func _ready():
	nivel = level_search("Node2D")
	if !jogador and nivel:
		jogador = nivel.get_node("BroColli")
	print_debug(nivel)
	print_debug(jogador)

func _process(delta):
	if !nivel:
		nivel = level_search("Node2D")
	if nivel:
		jogador = nivel.get_node("BroColli")
	if jogador:
		verificar_vida_player()

func verificar_vida_player():
	if jogador.vida_total < 0:
		game_over()

func _input(event):
	if event.is_action_pressed("cancelar"):
		jogo_pausado = !jogo_pausado
		emit_signal("pausar_jogo", jogo_pausado)

func mudar_nivel(file_path_lvl):
	prox_nivel = load(file_path_lvl)
	var new_lvl = prox_nivel.instantiate()
	var nivel_velho = nivel.get_children()
	add_child(new_lvl)
	for child in nivel_velho:
		child.queue_free()
	nivel.queue_free()
	nivel = new_lvl

func game_over():
	jogador.vida_total = Global.vidas_max
	get_tree().reload_current_scene()

func get_child_by_class(tipo_class):
	for child in get_children():
		if child.name == tipo_class:
			nivel = child

func level_search(name_class):
	loading = true
	print_debug(loading)
	var all_children = get_children()
	for classe : Node in all_children:
		print_debug(classe.get_class())
		if classe.is_class(name_class):
			print_debug(classe)
			return classe

#https://kayillustrations.itch.io/parallax-terrestrial-planet
#https://ansimuz.itch.io/mountain-dusk-parallax-background
