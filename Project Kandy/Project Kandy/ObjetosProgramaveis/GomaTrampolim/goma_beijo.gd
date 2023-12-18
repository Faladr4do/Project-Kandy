extends CharacterBody2D

var poder_salto = 4000

func _physics_process(delta):
	pass


func _on_area_pular_body_entered(body):
	if body.is_in_group("Vegetal"):
		body.velocity.y = poder_salto
