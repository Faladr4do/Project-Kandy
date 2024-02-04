extends Node
class_name GestorJogo

signal pausar_jogo(is_paused)

@export var nivel : PackedScene
#@export var jogador : PackedScene
@onready var jogador = $"Nivel1Part1/BroColli"

var jogo_pausado = false:
	get:
		return jogo_pausado
	set(valor):
		jogo_pausado = valor
		get_tree().paused = jogo_pausado
		emit_signal("pausar_jogo", jogo_pausado)

func _process(delta):
	verificar_vida_player()

func verificar_vida_player():
	if jogador.vida_total < 0:
		game_over()

func _input(event):
	if event.is_action_pressed("cancelar"):
		jogo_pausado = !jogo_pausado
		emit_signal("pausar_jogo", jogo_pausado)

func game_over():
	jogador.vida_total = Global.vidas_max
	get_tree().reload_current_scene()

#https://kayillustrations.itch.io/parallax-terrestrial-planet
#https://ansimuz.itch.io/mountain-dusk-parallax-background
