extends Objeto
class_name ObjetoVivo

@export var dano_forca : float = 1
@export var forca_knockback : float
@export var salto_forca : float
@export var velocidade : float

@export var animacoes : AnimationPlayer

@onready var anim_morte = animacoes

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
	if collisionPolygon and !collisionShape:
		collision = collisionPolygon
	elif collisionShape and !collisionPolygon:
		collision = collisionShape
	if delete_collision:
		hitbox.call_deferred("set_disabled", true)
		collision.call_deferred("set_disabled", true)
	estaMorrer = true
	await get_tree().create_timer(tempo_imune).timeout
	queue_free()

func shoot(cena : PackedScene, vel_projetil : float, caster : Marker2D):
	var cena_instanciada = cena.instantiate()
	if scale.y < 0:
		cena_instanciada.velocidade = -vel_projetil
	elif scale.y > 0:
		cena_instanciada.velocidade = vel_projetil
	owner.add_child(cena_instanciada)
	cena_instanciada.global_position = caster.global_position

func gestor_grupos():
	add_to_group("ObjetoVivo")
