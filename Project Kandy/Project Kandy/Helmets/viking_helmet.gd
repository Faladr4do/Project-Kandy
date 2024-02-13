extends Sprite2D

@onready var animacoes : AnimationPlayer = $AnimationPlayer

@export var hit_flash : AnimationPlayer
@export var som_destruidor : AudioStreamPlayer2D

var cair : float = 0
var destruido : bool = false
var som_usar : bool = true

func _physics_process(delta):
	if destruido:
		animacoes.play("destruir")
		if som_usar:
			print_debug("soneto da destruição")
			if !som_destruidor.playing:
				som_destruidor.play()
		som_usar = false
		#soneto_destruidor()
	else:
		animacoes.play("idle")

func soneto_destruidor():
	if som_usar:
		print_debug("soneto da destruição")
		if !som_destruidor.playing:
			som_destruidor.play()
		som_usar = false

func _on_audio_capacete_finished():
	queue_free()
	#if destruido:
		#print_debug("soa a bazar")
		#await get_tree().create_timer(1).timeout
		#queue_free()

func _on_animation_finished(anim_name):
	if anim_name == "destruir":
		hide()
