extends CharacterBody2D
class_name Objeto

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var vida_total : int
@export var vivo : bool = true
@export var delete_collision : bool = true
@export var tempo_imune : float = 0.6

@export var sprite : Sprite2D
@export var animacoes : AnimationPlayer
@export var hit_flash : AnimationPlayer
@export var hitbox : Area2D
@export var caster : Marker2D
@export var collisionPolygon : CollisionPolygon2D
@export var collisionShape : CollisionShape2D

var receber_dano = false
var esta_atacar = false
var esta_correr = false
var estaMorrer = false
var collision

func _process(delta):
	hit_flash_play()
	gestor_grupos()

func hit_flash_play():
	if receber_dano:
		if is_in_group("Vegetal"):
			hitbox.monitoring = false
		if $Hurt and !$Hurt.playing:
			$Hurt.play()
		if hit_flash:
			hit_flash.play("hit_flash")
		await get_tree().create_timer(tempo_imune).timeout
		receber_dano = false
		if hitbox:
			hitbox.monitoring = true

func dano(dano_ataque: Ataque):
	if !receber_dano:
		vida_total -= dano_ataque.dano_ataque
		if dano_ataque.dano_ataque:
			receber_dano = true
		velocity = (global_position - dano_ataque.posicao_ataque).normalized() * dano_ataque.forca_knockback

func gestor_grupos():
	add_to_group("Objeto")
