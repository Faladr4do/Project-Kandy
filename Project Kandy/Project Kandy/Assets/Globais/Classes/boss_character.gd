extends ObjetoVivo
class_name Boss_Character

var vida_fase2 : float

var local_player
var distance_player
var player

func _ready():
	var nivel = get_parent()
	player = nivel.jogador
	add_to_group("Boss")
	vida_fase2 = vida_total * 0.4

func _process(delta):
	local_player = player.global_position.x
	distance_player = local_player - global_position.x
	is_alive()
	#print_debug(distance_player)

func is_alive():
	if vida_total <= 0 and !esta_atacar:
		if !estaMorrer:
			animacoes.play("death")
