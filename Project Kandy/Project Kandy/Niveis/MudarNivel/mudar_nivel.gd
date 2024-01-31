extends Area2D

@export var area_nivel : CollisionShape2D
@export var nivel_alvo : PackedScene

func _on_body_entered(body):
	if body.is_in_group("Vegetal"):
		body.velocidade *= 0
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_packed(nivel_alvo)
