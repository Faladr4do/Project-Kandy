extends Control

@export var gerenciador_jogo : GerenciadorJogo = GerenciadorJogo.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	gerenciador_jogo.connect("toggle_game_paused", on_game_manager_toggle_game_paused)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_game_manager_toggle_game_paused(is_paused):
	if is_paused:
		show()
	else:
		hide()


func _on_botao_jogar_pressed():
	gerenciador_jogo. game_paused = false

func _on_botao_reiniciar_pressed():
	get_tree().reload_current_scene()

func _on_botao_configurar_pressed():
	pass # Replace with function body.


func _on_botao_sair_pressed():
	get_tree().quit()


func _on_botao_voltar_menu_pressed():
	get_tree().change_scene_to_file("res://Project Kandy/Menus/menu_principal.tscn")
