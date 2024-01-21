extends Node2D

@onready var jogador = get_tree().get_first_node_in_group("Vegetal")
@onready var texto = $Label

const texto_base = "[E] para "

var areas_ativas = []
var pode_interagir = true

func registar_area(area: AreaInteragir):
	areas_ativas.push_back(area)
	
func desregistar_area(area: AreaInteragir):
	var index = areas_ativas.find(area)
	if index != -1:
		areas_ativas.remove_at(index)
		
func _process(delta):
	if areas_ativas.size() > 0 and pode_interagir:
		areas_ativas.sort_custom(ordenar_distancia_jogador)
		texto.text = texto_base + areas_ativas[0].nome_acao
		texto.global_position = areas_ativas[0].global_position
		texto.global_position.y -= 36
		texto.global_position.x -= texto.size.x / 2
		texto.show()
	else:
		texto.hide()
		
func ordenar_distancia_jogador(area1, area2):
	var distancia_area1 = jogador.global_position.distance_to(area1.global_position)
	var distancia_area2 = jogador.global_position.distance_to(area1.global_position)
	return distancia_area1 < distancia_area2
	
func _input(event):
	if event.is_action_pressed("interagir") and pode_interagir:
		if areas_ativas.size() > 0:
			pode_interagir = false
			texto.hide()
			await areas_ativas[0].interagir.call()
			pode_interagir = true
