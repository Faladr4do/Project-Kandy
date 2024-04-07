extends Node
class_name GestorJogo

signal pausar_jogo(is_paused)

var nivel_velho
var nivel
var prox_nivel
var jogador

var jogo_pausado = false:
	get:
		return jogo_pausado
	set(valor):
		jogo_pausado = valor
		get_tree().paused = jogo_pausado
		emit_signal("pausar_jogo", jogo_pausado)

func _ready():
	nivel = level_search("NivelCena")
	if !jogador and nivel:
		jogador = nivel.get_node("BroColli")

#func _process(delta):
	#if jogador:
		#verificar_vida_player()
#
#func verificar_vida_player():
	#if jogador.vida_total < 0:
		#game_over()

func _input(event):
	if event.is_action_pressed("cancelar"):
		jogo_pausado = !jogo_pausado
		emit_signal("pausar_jogo", jogo_pausado)

func mudar_nivel(file_path_lvl):
	prox_nivel = load(file_path_lvl)
	var new_lvl = prox_nivel.instantiate()
	var nivel_velho = nivel.get_children()
	var all_children = nivel_velho.get_children()
	add_child(new_lvl)
	for child in all_children:
		child.queue_free()
	nivel.replace_by(new_lvl)

func game_over():
	jogador.vida_total = Global.vidas_max
	get_tree().reload_current_scene()

func get_child_by_class(tipo_class):
	for child in get_children():
		if child.name == tipo_class:
			nivel = child

func level_search(name_class):
	var all_children = get_children()
	for classe in all_children:
		if classe.is_class(name_class):
			return classe

#https://kayillustrations.itch.io/parallax-terrestrial-planet
#https://ansimuz.itch.io/mountain-dusk-parallax-background
