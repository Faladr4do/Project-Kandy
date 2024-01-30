extends Area2D

@export var colisao : CollisionShape2D
@export var queda : bool = false
@export var tempo_queda : float = 0.8

func _on_body_entered(body):
	if body.is_in_group("Inimigo"):
		body.virar()
	if body.is_in_group("Vegetal") and queda:
		await get_tree().create_timer(tempo_queda).timeout
		get_tree().reload_current_scene()
