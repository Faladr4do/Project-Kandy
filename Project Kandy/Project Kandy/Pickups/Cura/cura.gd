extends Sprite2D

@onready var coletar_som = $Area2D/AudioStreamPlayer2D

var cura = 1

var coletada = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("Vegetal") and !coletada:
		if body.vida_total == Global.vidas_max:
			pass
		else:
			coletada = true
			coletar_som.play()
			body.vida_total += cura
			hide()
