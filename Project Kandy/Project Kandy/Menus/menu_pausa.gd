extends Control

@export var gerenciador_jogo : GestorJogo
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	gerenciador_jogo.connect("pausar_jogo", on_game_manager_toggle_jogo_pausado)

func _process(delta):
	pass

func on_game_manager_toggle_jogo_pausado(is_paused):
	if is_paused:
		show()
	else:
		hide()


func _on_botao_jogar_pressed():
	gerenciador_jogo.jogo_pausado = false

func _on_botao_reiniciar_pressed():
	gerenciador_jogo.jogo_pausado = false
	Global.moedas_coletadas = Checkpoint.moedas_coletadas
	get_tree().reload_current_scene()

func _on_botao_configurar_pressed():
	gerenciador_jogo.jogo_pausado = false
	Menu.menu_conf_back = true
	get_tree().change_scene_to_file("res://Project Kandy/Menus/menu_configurar.tscn")

func _on_botao_sair_pressed():
	get_tree().quit()

func _on_botao_voltar_menu_pressed():
	gerenciador_jogo.jogo_pausado = false
	get_tree().change_scene_to_file("res://Project Kandy/Menus/menu_index.tscn")
