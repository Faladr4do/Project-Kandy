extends Objeto
class_name ObjetoExplosivo

@export var kaboom : PackedScene

func explodir():
	var cena_explosiva = kaboom.instantiate()
	cena_explosiva.cor = 1
	owner.call_deferred("add_child", cena_explosiva)
	cena_explosiva.global_position = sprite.global_position

func gestor_grupos():
	add_to_group("ObjetoExplosivo")
