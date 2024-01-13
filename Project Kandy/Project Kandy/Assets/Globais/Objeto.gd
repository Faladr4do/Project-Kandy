extends CharacterBody2D
class_name Objeto

@export var vida_total : int
@export var vivo : bool = true
@export var delete_collision : bool = true
@export var tempo_imune : float = 0.6

@export var sprite : Sprite2D
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

func _ready():
	hitbox.add_to_group("Hitbox")

func hit_flash_play():
	if receber_dano:
		hitbox.monitoring = false
		if hit_flash:
			hit_flash.play("hit_flash")
		await get_tree().create_timer(tempo_imune).timeout
		receber_dano = false
		hitbox.monitoring = true
