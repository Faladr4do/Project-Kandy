extends Area2D

@export var colisao : CollisionShape2D
@export var queda : bool = false

func _on_body_entered(body):
	if body.is_in_group("Inimigo"):
		body.virar()
	if body.is_in_group("Vegetal") and queda:
		get_tree().reload_current_scene()
