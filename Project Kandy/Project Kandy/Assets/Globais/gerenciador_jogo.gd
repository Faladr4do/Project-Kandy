extends Node

class_name GerenciadorJogo

signal toggle_game_paused(is_paused)

@onready var jogador = $MapaTestes/BroColli

var game_paused = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

func _process(delta):
	verificar_vida_player()

func verificar_vida_player():
	if jogador.vida_total < 0:
		game_over()

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("cancelar"):
		game_paused = !game_paused

func game_over():
	get_tree().reload_current_scene()
