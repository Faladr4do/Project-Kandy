extends Area2D

@export var sprite_chama : Sprite2D
@export var chama : AnimationPlayer

var guardado : bool

func _ready():
	chama.play("desacesa")

func _on_Checkpoint_body_entered(body):
	if body.is_in_group("Vegetal") and !guardado:
		print_debug("checkpoint")
		Checkpoint.ultima_posicao = global_position
		chama.play("acender")
		guardado = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "acender":
		chama.play("acesa")
