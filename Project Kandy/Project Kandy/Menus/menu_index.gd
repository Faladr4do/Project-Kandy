extends Control

@export var nivel_atual : PackedScene
@export var imagem_fundo : Texture2D

@onready var cena_opcoes = "res://Project Kandy/Menus/menu_configurar.tscn"
@onready var textura_fundo : TextureRect = $ImagemFundo

func _ready():
	#Automaticamente enviar a imagem de fundo do Index para outros derivados de menus
	#if cena_opcoes:
		#print_debug(cena_opcoes.imagem_fundo)
		#cena_opcoes.imagem_fundo = imagem_fundo
	if imagem_fundo:
		textura_fundo.texture = imagem_fundo

func _on_jogar_botao_pressed():
	get_tree().change_scene_to_packed(nivel_atual)

func _on_configurar_botao_pressed():
	get_tree().change_scene_to_file(cena_opcoes)

func _on_sair_botao_pressed():
	get_tree().quit()
