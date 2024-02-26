extends Area2D

@onready var animGoma = $AnimationPlayer

@export var poder_salto : float = 16
var usavel : bool = true

func _physics_process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Vegetal") or body.is_in_group("Inimigo"):
		print("saltar")
		animGoma.play("goma_jump")
		body.animacoes.play("jump")
		body.velocity.y = -poder_salto * 100
		if body.is_in_group("Vegetal"):
			body.doubleJump = true

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "goma_jump":
		animGoma.play("idle")
