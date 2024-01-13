extends ObjetoVivo
class_name VegetalPlayer

func _process(delta):
	gestor_grupos()

func gestor_grupos():
	add_to_group("Vegetal")
