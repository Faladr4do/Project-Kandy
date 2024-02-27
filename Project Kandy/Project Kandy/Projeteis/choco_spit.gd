extends Area2D
@export var dano_forca : float = 1
@export var forca_knockback : float = 1000
@export var velocidade : float 

@onready var anim_spit = $AnimationPlayer
@onready var sprite_spit = $Sprite2D
@onready var gestor_alcance = $gestor_alcance

var infinite_range : bool = false

func _ready():
	add_to_group("Bala")
	add_to_group("Incendiar")
	if !infinite_range:
		gestor_alcance.start()

func _physics_process(delta):
	position += transform.x * velocidade * delta
	if velocidade < 0:
		sprite_spit.flip_v= true

func _on_body_entered(body):
	print(body.get_groups())
	if body.is_in_group("Vegetal"):
		var ataque = Ataque.new()
		ataque.dano_ataque = dano_forca
		ataque.forca_knockback = forca_knockback
		ataque.posicao_ataque = global_position
		body.dano(ataque)
		velocidade = 0
		anim_spit.play("explodir")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "explodir" or anim_name == "extinguir":
		queue_free()

func _on_gestor_alcance_timeout():
	anim_spit.play("extinguir")
