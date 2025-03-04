extends CanvasLayer

@onready var mostrar_moedas : Label = $Moedas
@onready var mostrar_vidas : Label = $Vidas

var jogador

func _process(_delta):
	if !jogador:
		jogador = get_parent().jogador
	else:
		mostrar_moedas.text = "Coins: "+ str(Global.moedas_coletadas)
		mostrar_vidas.text = "Lives: "+ str(jogador.vida_total)
