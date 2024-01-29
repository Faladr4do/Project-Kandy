extends Area2D

@onready var jogador : CharacterBody2D = $BroColli

func _enter_tree():
	if Checkpoint.last_position:
		jogador.global_position = Checkpoint.global_position
