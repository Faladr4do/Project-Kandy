extends Sprite2D

@onready var coletar_som = $Area2D/AudioStreamPlayer2D

var coletada = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("Vegetal") and !coletada:
		if Global.vidas_max == Global.vidas_totais:
			pass
		else:
			coletada = true
			coletar_som.play()
			Global.vidas_totais += 1
			hide()
