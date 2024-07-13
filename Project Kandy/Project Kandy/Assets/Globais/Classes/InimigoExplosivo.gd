extends InimigoBase
class_name InimigoExplosivo

@export var kaboom : PackedScene

func explodir():
	var cena_explosiva = kaboom.instantiate()
	cena_explosiva.cor = 1
	owner.add_child(cena_explosiva)
	cena_explosiva.global_position = caster.global_position

func gestor_grupos():
	add_to_group("InimigoExplosivo")
