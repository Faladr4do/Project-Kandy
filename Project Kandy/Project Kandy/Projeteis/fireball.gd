extends Area2D

#var direcao = Vector2.RIGHT
var velocidade = -90

func _ready():
	add_to_group("Bala")

func _physics_process(delta):
	position += transform.x * velocidade * delta
	
func _on_body_entered(body):
	if body.is_in_group("Inimigo"):
		pass
	elif body.is_in_group("Alvo"):
		pass
	
