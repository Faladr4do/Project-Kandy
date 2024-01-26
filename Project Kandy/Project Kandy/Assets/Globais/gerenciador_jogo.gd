extends Node
class_name GestorJogo

signal pausar_jogo(is_paused)

@onready var jogador = $MapaTestes/BroColli

var game_paused = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("pausar_jogo", game_paused)

func _process(delta):
	verificar_vida_player()

func verificar_vida_player():
	if jogador.vida_total < 0:
		game_over()

func _input(event):
	if event.is_action_pressed("cancelar"):
		game_paused = !game_paused
		emit_signal("pausar_jogo", game_paused)

func game_over():
	await get_tree().create_timer(4).timeout
	jogador.vida_total = Global.vidas_max
	get_tree().reload_current_scene()

#https://kayillustrations.itch.io/parallax-terrestrial-planet
#https://ansimuz.itch.io/mountain-dusk-parallax-background
