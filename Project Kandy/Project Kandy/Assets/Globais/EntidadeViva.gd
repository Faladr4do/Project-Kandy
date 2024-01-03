extends CharacterBody2D
class_name EntidadeViva

@export var vida_total : int
@export var vivo : bool = true
@export var dano_forca : float
@export var forca_knockback : float
@export var salto_forca : float
@export var velocidade : float
@export var tempo_imune : float = 0.6

@export var animacoes : AnimationPlayer
@export var sprite : Sprite2D
@export var hit_flash : AnimationPlayer
@export var hitbox : Area2D

var receber_dano = false
var esta_atacar = false
var esta_correr = false
var estaMorrer = false
@onready var anim_morte = animacoes

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hit_flash_play()

func dano(dano_ataque: Ataque, bool_morte = 0):
	vida_total -= dano_ataque.dano_ataque
	print(vida_total)
	if vida_total < 0:
		bool_morte = true
	receber_dano = true
	velocity = (global_position - dano_ataque.posicao_ataque).normalized() * dano_ataque.forca_knockback

func hit_flash_play():
	if receber_dano:
		hitbox.monitoring = false
		hit_flash.play("hit_flash")
		await get_tree().create_timer(tempo_imune).timeout
		receber_dano = false
		hitbox.monitoring = true

func funcao_morte():
	estaMorrer = true
	animacoes.play("death")
	await animacoes.animation_finished
	queue_free()

func auto_animar(walk, idle, jump, fall):
	if is_on_floor() and !esta_atacar:
		if velocity.x != 0:
			animacoes.play(walk)
		else:
			animacoes.play(idle)
	elif !is_on_floor():
		if velocity.y < 0:
			animacoes.play(jump, -1, 1)
		elif velocity.y > 0:
			animacoes.play(fall)

func estou_vivo():
	if vida_total < 0:
		morte()

func morte():
	if estaMorrer:
		return
	animacoes.play("dead")
	$hitbox/CollisionPolygon2D.call_deferred("set_disabled", true)
	$CollisionPolygon2D.call_deferred("set_disabled", true)
	estaMorrer = true
	await get_tree().create_timer(0.75).timeout
	queue_free()
#func tempo_hit_flash(hit_flash: AnimationPlayer):
	#tempo_imune = hit_flash.get_animation_length("hit_flash")
