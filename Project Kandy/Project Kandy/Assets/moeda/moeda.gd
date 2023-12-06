extends Sprite2D

@onready var coletar_som = $Area2D/AudioStreamPlayer2D

var coletada = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("Vegetal") and !coletada:
		coletada = true
		coletar_som.play()
		Global.moedas_coletadas += 1
		hide()
