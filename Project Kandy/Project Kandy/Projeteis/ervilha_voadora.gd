extends Area2D

@export var dano_forca : float = 1
@export var forca_knockback : float = 2000
@export var velocidade : float 

@onready var anim_pea = $AnimationPlayer
@onready var sprite_pea = $Sprite2D
@onready var gestor_alcance = $GestorAlcance
@onready var colisao = $CollisionShape2D

var infinite_range : bool = false

func _ready():
	add_to_group("Bala")
	add_to_group("Incendiar")
	if !infinite_range:
		gestor_alcance.start()

func _physics_process(delta):
	position += transform.x * velocidade * delta
	if velocidade < 0:
		sprite_pea.flip_v= true

func _on_body_entered(body):
	if body.is_in_group("Inimigo") or body.is_in_group("ObjetoExplosivo") or body.is_in_group("Objeto") or body.is_in_group("Boss"):
		var ataque = Ataque.new()
		ataque.dano_ataque = dano_forca
		if !body.is_in_group("Boss"):
			ataque.forca_knockback = forca_knockback
		ataque.posicao_ataque = global_position
		body.dano(ataque)
	extinguir_colisao()

func extinguir_colisao():
	gestor_alcance.stop()
	velocidade = 0
	queue_free()

func _on_animation_finished(anim_name):
	if anim_name == "explodir" or anim_name == "extinguir":
		queue_free()

func _on_gestor_alcance_timeout():
	queue_free()
