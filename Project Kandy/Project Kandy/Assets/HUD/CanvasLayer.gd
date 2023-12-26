extends CanvasLayer

@onready var mostrar_moedas = $Label
@onready var mostrar_vidas = $Label2

func _process(_delta):
	mostrar_moedas.text = "Moedas: "+ str(Global.moedas_coletadas)
	mostrar_vidas.text = "Vidas: "+ str(Global.vidas_totais)
