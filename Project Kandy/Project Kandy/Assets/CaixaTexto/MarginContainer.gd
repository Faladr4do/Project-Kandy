extends MarginContainer

@onready var texto_fala = $MarginContainer/Label
@onready var tempo_leitura = $TempoLeitura

const MAX_WIDTH = 256

var texto = ""
var num_letras = 0
var tempo_letra = 0.03
var tempo_espaco = 0.06
var tempo_pontuar = 0.2

signal acabou_de_mostrar()

func mostrar_texto(texto_mostra: String):
	texto = texto_mostra
	texto_fala.text = texto_mostra
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	if size.x > MAX_WIDTH:
		texto_fala.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
	global_position.x -= size.x / 2
	global_position.x -= size.y + 24
	texto_fala.text = ""
	mostrar_fala()
	
func mostrar_fala():
	texto_fala.text += texto[num_letras]
	num_letras += 1
	if num_letras >= texto.length():
		acabou_de_mostrar.emit()
		return
	match texto[num_letras]:
		"!", ".", ",", "?":
			tempo_leitura.start(tempo_pontuar)
		" ":
			tempo_leitura.start(tempo_espaco)
		_:
			tempo_leitura.start(tempo_letra)

func _on_tempo_leitura_timeout():
	mostrar_fala()
