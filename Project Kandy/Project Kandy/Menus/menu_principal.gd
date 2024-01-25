extends Control

@export var menu_opcoes : PackedScene
@export var menu_principal : VBoxContainer
@export var cena_jogo : PackedScene

func _on_botao_jogar_pressed():
	get_tree().change_scene_to_packed(cena_jogo)

func _on_botao_definições_pressed():
	get_tree().change_scene_to_packed(menu_opcoes)

func _on_botao_sair_pressed():
	get_tree().quit()
