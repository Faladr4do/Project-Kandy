extends Sprite2D

@onready var carro_full : CompressedTexture2D = load("res://Project Kandy/Objetos/PeaCart/sprite/PeaCartFull.png")
@onready var carro_half : CompressedTexture2D = load("res://Project Kandy/Objetos/PeaCart/sprite/PeaCartHalf.png")

var dono_carro

func _ready():
	dono_carro = get_parent()
	if !Dialogic.VAR.ervilhas:
		texture = carro_full

func _process(delta):
	if Dialogic.VAR.ervilhas:
		texture = carro_half
