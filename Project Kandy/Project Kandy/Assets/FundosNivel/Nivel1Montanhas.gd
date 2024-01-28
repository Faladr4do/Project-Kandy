extends ParallaxBackground

@export var nivel : int = 1
@export var plano_fundo_ceu : Sprite2D
@export var plano_fundo_longe : Sprite2D
@export var plano_fundo_longe2 : Sprite2D
@export var plano_fundo_perto : Sprite2D

func _process(delta):
	pass
	#match nivel:
		#1:
			#plano_fundo_ceu.texture = "res://Project Kandy/Assets/Tiles/Sky.png"
