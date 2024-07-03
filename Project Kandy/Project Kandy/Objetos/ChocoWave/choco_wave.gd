extends Area2D

@export var dano_forca : float = 1
@export var forca_knockback : float = 2000
@export var velocidade : float 

@onready var anim_fire = $AnimationPlayer
@onready var sprite_fire = $Sprite2D
@onready var gestor_alcance = $gestor_alcance
@onready var colisao = $CollisionPolygon2D

var infinite_range : bool = false

func _ready():
	add_to_group("Bala")
	add_to_group("Incendiar")
	if !infinite_range:
		gestor_alcance.start()

func _physics_process(delta):
	if velocidade > 0:
		position += transform.x * velocidade * delta
		scale.x = -1
	else:
		position -= transform.x * velocidade * delta
		scale.x = 1

func _on_body_entered(body):
	if body.is_in_group("ColunaGolem"):
		queue_free()
	if body.is_in_group("Vegetal"):
		var ataque = Ataque.new()
		ataque.dano_ataque = dano_forca
		ataque.forca_knockback = forca_knockback
		ataque.posicao_ataque = global_position
		body.dano(ataque)
		queue_free()

func _on_gestor_alcance_timeout():
	queue_free()

func _on_animation_finished(anim_name):
	if anim_name == "spawn":
		anim_fire.play("idle")


func _on_area_entered(area):
	if area.is_in_group("Bala"):
		area.queue_free()
