extends Objeto

const NAME_PREFIX = "res://Project Kandy/Objetos/ChocoColumn/sprite/ChocoColumn"

var nome_anim : String
var tipo_coluna : String

func _ready():
	add_to_group("Objeto")
	var rng_number = randf()
	if rng_number < 0.5:
		tipo_coluna = "coluna_1"
	else:
		tipo_coluna = "coluna_2"
	animacoes.play(tipo_coluna)

func _process(delta):
	anim_health_status()

func anim_health_status():
	nome_anim = str(NAME_PREFIX + str(vida_total+1) + ".png")
	if vida_total >= 0:
		sprite.texture = load(nome_anim)
	else:
		await get_tree().create_timer(tempo_imune).timeout
		queue_free()
