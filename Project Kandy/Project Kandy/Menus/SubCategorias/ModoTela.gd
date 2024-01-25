extends HBoxContainer

@export var botao_opcoes : OptionButton

const MODO_TELA_ARRAY : Array[String] = [
	"Tela-Cheia",
	"Modo janela",
	"Janela sem bordas",
	"Tela-Cheia sem bordas"
]

func _ready():
	botao_opcoes.item_selected.connect(modo_tela_selecionado)

func modo_tela_selecionado(selecionado):
	match selecionado:
		0: #Tela-Cheia
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: #Modo janela
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: #Janela sem bordas
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: #Tela-Cheia sem bordas
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
