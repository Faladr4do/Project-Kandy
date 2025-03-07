extends Control

@export var imagem : Texture2D

@onready var menu = "res://Project Kandy/Menus/menu_index.tscn"
@onready var jogo = "res://jogo_full.tscn"
@onready var textura_fundo = $TextureRect

func _ready():
	if imagem:
		textura_fundo.texture = imagem

func _on_sair_botao_pressed():
	if Menu.menu_conf_back:
		get_tree().change_scene_to_file(jogo)
		Menu.menu_conf_back = false
	else:
		get_tree().change_scene_to_file(menu)
