extends CharacterBody2D

@export var area_interacao : AreaInteragir

func _ready():
	area_interacao.interagir = Callable(self, "inter_act")

func inter_act():
	pass
