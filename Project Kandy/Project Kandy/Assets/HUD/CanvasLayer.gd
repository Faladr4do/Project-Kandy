extends CanvasLayer

@export var mostrar_moedas : Label
@export var mostrar_vidas : Label
@onready var jogador = $"../Nivel1Part1/BroColli"

func _process(_delta):
	mostrar_moedas.text = "Moedas: "+ str(Global.moedas_coletadas)
	mostrar_vidas.text = "Vidas: "+ str(jogador.vida_total)
