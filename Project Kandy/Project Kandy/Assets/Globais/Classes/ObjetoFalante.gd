extends CharacterBody2D
class_name ObjetoFalante

@export var area_interacao : AreaInteragir
@export var dialogo : String = "sem_dialogo"

func _ready():
	area_interacao.interagir = Callable(self, "inter_act")

func inter_act():
	if Dialogic.current_timeline != null:
		return
	Dialogic.start(dialogo)
	get_viewport().set_input_as_handled()
