extends InimigoBase

@onready var hound_prelunge : AudioStreamPlayer2D = $PreLunge
@onready var hound_lunge : AudioStreamPlayer2D = $Lunge
@onready var hound_hurt : AudioStreamPlayer2D = $Hurt

@export var area_visao : Area2D

var carga_doce : bool = false
const TEMPO_CARGA : float = 1.0
var carga_acc : float = 0.0
var stop : bool = false
var animacao_atual : String

func _ready():
	if lado_esquerdo:
		virar()
	if vida_total > 0:
		colocar_capacete()

func _physics_process(delta):
	if estaMorrer:
		return
	if !is_on_floor():
		velocity.y += gravity * delta
	elif is_on_floor():
		if chao_detect.is_colliding():
			if !carga_doce and !stop:
				velocity.x = -velocidade
			elif carga_doce:
				carga_acc += delta
				if carga_acc >= TEMPO_CARGA or !chao_detect.is_colliding():
					carga_doce = false
					stopper()
					carga_acc = 0
		elif !chao_detect.is_colliding():
			carga_doce = false
			virar()
	animacao_atual = animacoes.get_assigned_animation()
	destruir_capacete()
	estou_vivo()
	if !carga_doce:
		auto_animar("walk", "spot", "jump", "fall")
	elif carga_doce:
		if !animacao_atual == "lunge":
			if !hound_lunge.playing:
				animacoes.play("lunge")
			hound_lunge.play()
	move_and_slide()

func fall():
	if !is_on_floor() and position.y > 200000:
		animacoes.play("fall")

func _on_target_body_entered(body):
	#Caso o inimigo tenha mais de duas vidas o player vai ser afetado só pelo knockback
	if vida_total >= 0  and body.is_in_group("Vegetal"):
		body.velocity.y = -forca_knockback * 0.4

func _on_hitbox_body_entered(body):
	if estaMorrer:
		return
	if body.is_in_group("Vegetal"):
		var ataque = Ataque.new()
		ataque.dano_ataque = dano_forca
		ataque.forca_knockback = forca_knockback
		ataque.posicao_ataque = global_position
		body.dano(ataque)
		virar()

func _on_teste_parede_body_entered(body):
	if body.is_in_group("Vegetal") or body.is_in_group("Bala"):
		pass
	else:
		virar()

func virar():
	scale.x = abs(scale.x) * -1
	velocidade= -velocidade
	carga_acc = 0
	carga_doce = false

func _on_spot_body_entered(body):
	if body.is_in_group("Vegetal"):
		stop = true
		velocity.x = 0
		if !animacao_atual == "spot":
			animacoes.play("spot")
		await animacoes.animation_finished
		stop = false
		velocity.x = -velocidade * 6
		carga_doce = true

#func stopper():
	#velocity.x = 0
	#print_debug("ini")
	#await get_tree().create_timer(1).timeout
	#print_debug("fin")
	#velocity.x = velocidade

func stopper():
	stop = true
	await get_tree().create_timer(1).timeout
	stop = false
