extends InimigoBase
class_name InimigoExplosivo

@export var kaboom : PackedScene

func _ready():
	add_to_group("InimigoExplosivo")

func explodir():
	var cena_explosiva = kaboom.instantiate()
	cena_explosiva.cor = 1
	owner.call_deferred("add_child", cena_explosiva)
	cena_explosiva.global_position = caster.global_position
