extends Node2D

@export var jogador : CharacterBody2D

func _enter_tree():
	if Checkpoint.ultima_posicao:
		print_debug(jogador)
		jogador.global_position = Checkpoint.ultima_posicao
