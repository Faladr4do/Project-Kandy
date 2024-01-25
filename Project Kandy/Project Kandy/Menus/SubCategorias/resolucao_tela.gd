extends HBoxContainer

@export var botao_opcoes : OptionButton

const DICIONARIO_RESOLUCOES : Dictionary = {
	"640x480" : Vector2i(640,480),
	"800x600" : Vector2i(800,600),
	"1366x768" : Vector2i(1366,768),
	"1600x900" : Vector2i(1600,900),
	"1920x1080" : Vector2i(1920,1080),
	"2560x1440" : Vector2i(2560,1440),
	"3840x2160" : Vector2i(3840,2160)
}

func _ready():
	botao_opcoes.item_selected.connect(resolucao_selecionada)
	adicionar_itens_resolucao()

func adicionar_itens_resolucao():
	for texto_resolucao in DICIONARIO_RESOLUCOES:
		botao_opcoes.add_item(texto_resolucao)

func resolucao_selecionada(selecionado):
	DisplayServer.window_set_size(DICIONARIO_RESOLUCOES.values()[selecionado])
