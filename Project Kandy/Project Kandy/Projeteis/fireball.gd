extends Area2D

#var direcao = Vector2.RIGHT
var velocidade

@onready var sprite_estigada = $Sprite2D

func _ready():
	add_to_group("Bala")

func _physics_process(delta):
	position += transform.x * velocidade * delta
	if velocidade < 0:
		sprite_estigada.flip_h= true
		sprite_estigada.rotation_degrees = 21.8
	else:
		pass
	
func _on_body_entered(body):
	if body.is_in_group("Inimigo"):
		pass
	elif body.is_in_group("Alvo"):
		pass
	