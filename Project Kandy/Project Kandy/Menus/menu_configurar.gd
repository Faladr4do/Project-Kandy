extends Control

@export var menu_principal : PackedScene
@export var imagem : Texture2D

@onready var menu = "res://Project Kandy/Menus/menu_index.tscn"
@onready var textura_fundo = $TextureRect

func _ready():
	if imagem:
		textura_fundo.texture = imagem

func _on_sair_botao_pressed():
	print_debug(menu_principal)
	get_tree().change_scene_to_file(menu)
