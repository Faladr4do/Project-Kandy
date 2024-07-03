extends Objeto

@export var spawn_coln : AudioStreamPlayer2D
@export var emerge : AudioStreamPlayer2D

const NAME_PREFIX = "res://Project Kandy/Objetos/ColunasGolem/sprites/ChocoColumn"

var nome_anim : String
var tipo_coluna : String

var velocidade = 0

func _ready():
	add_to_group("Objeto")
	add_to_group("ColunaGolem")
	var rng_number = randf()
	if rng_number < 0.5:
		tipo_coluna = "coluna_1"
	else:
		tipo_coluna = "coluna_2"
	animacoes.play(tipo_coluna)

func _process(delta):
	collisionShape.global_position = sprite.global_position
	anim_health_status()

func anim_health_status():
	nome_anim = str(NAME_PREFIX + str(3) + ".png")
	if vida_total >= 0:
		sprite.texture = load(nome_anim)
	else:
		await get_tree().create_timer(tempo_imune).timeout
		queue_free()

func _on_animation_started(anim_name):
	if anim_name == "spawn_too":
		spawn_coln.play()
		await get_tree().create_timer(0.7).timeout
		emerge.play()
