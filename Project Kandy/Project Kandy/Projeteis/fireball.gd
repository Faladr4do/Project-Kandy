extends Area2D

#var direcao = Vector2.RIGHT

@export var dano_forca : float = 1
@export var forca_knockback : float = 2000
@export var velocidade : float 

var desaparecer = false

var distancia
var posicao_ini

@onready var sprite_estigada = $Sprite2D

func _ready():
	add_to_group("Bala")

func _physics_process(delta):
	position += transform.x * velocidade * delta
	if velocidade < 0:
		sprite_estigada.flip_h= true
		sprite_estigada.rotation_degrees = 21.8
	else:
		pass
	if desaparecer:
		queue_free()

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print(area.get_groups())
	if area.is_in_group("Hitbox"):
		var ataque = Ataque.new()
		ataque.dano_ataque = dano_forca
		ataque.forca_knockback = forca_knockback
		ataque.posicao_ataque = global_position
		area.dano(ataque)

#func _on_body_entered(body):
	#print("body " % body.get_groups())
	#if body.is_in_group("Hitbox"):
		#var ataque = Ataque.new()
		#ataque.dano_ataque = dano_forca
		#ataque.forca_knockback = forca_knockback
		#ataque.posicao_ataque = global_position
		#body.dano(ataque)
