extends Area2D

#var direcao = Vector2.RIGHT
var velocidade = -90
var ladoD

func _physics_process(delta):
	position += transform.x * velocidade * delta
func _on_body_entered(body):
	add_to_group("bala")
	if body.is_in_group("Inimigo"):
		queue_free()
	
