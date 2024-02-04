extends Area2D

class_name AreaInteragir

@export var nome_acao = "interagir"

var interagir : Callable = func():
	pass

func _on_body_entered(body):
	print("entrou")
	Interagir.registar_area(self)


func _on_body_exited(body):
	print("saiu")
	Interagir.desregistar_area(self)
