extends Node
class_name NivelCena

@export var jogador : CharacterBody2D

func _enter_tree():
	if Checkpoint.ultima_posicao:
		jogador.global_position = Checkpoint.ultima_posicao
