extends CanvasLayer

@onready var mostrar_moedas : Label = $Moedas
@onready var mostrar_vidas : Label = $Vidas

var jogador

func _process(_delta):
	if !jogador:
		print_debug(get_parent().jogador)
		jogador = get_parent().jogador
	mostrar_moedas.text = "Moedas: "+ str(Global.moedas_coletadas)
	mostrar_vidas.text = "Vidas: "+ str(jogador.vida_total)
