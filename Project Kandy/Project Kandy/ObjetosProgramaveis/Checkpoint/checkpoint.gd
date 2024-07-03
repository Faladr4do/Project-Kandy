extends Area2D

@onready var check_point = $Check

@export var sprite_chama : Sprite2D
@export var chama : AnimationPlayer

var nivel = null
var guardado : bool

func _ready():
	chama.play("desacesa")

func _on_Checkpoint_body_entered(body):
	if body.is_in_group("Vegetal") and !guardado:
		print_debug("checkpoint")
		Checkpoint.ultima_posicao = global_position + Vector2(0,-50)
		print_debug(get_parent().get_parent())
		nivel = get_parent().get_parent()
		Checkpoint.nivel_atual = nivel
		chama.play("acender")
		guardado = true
		await get_tree().create_timer(.3).timeout
		check_point.play()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "acender":
		chama.play("acesa")
