extends Node

class_name GerenciadorJogo

signal toggle_game_paused(is_paused)

var game_paused = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("cancelar"):
		game_paused = !game_paused
