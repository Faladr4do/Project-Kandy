extends Control

@export var botao_sair : Button


signal sair_menu_opcoes

# Called when the node enters the scene tree for the first time.
func _ready():
	botao_sair.button_down.connect(clicar_voltar)
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#https://www.youtube.com/watch?v=fFIST_4wmyI
	pass

func clicar_voltar():
	sair_menu_opcoes.emit()
	set_process(false)
