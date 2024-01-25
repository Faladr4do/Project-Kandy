extends Control

@export var menu_principal : PackedScene

func _on_sair_pressed():
	get_tree().change_scene_to_file("res://Project Kandy/Menus/menu_principal.tscn")
