extends Area2D

func _on_Checkpoint_body_entered(body):
	print_debug("checkpoint")
	Checkpoint.ultima_posicao = global_position
