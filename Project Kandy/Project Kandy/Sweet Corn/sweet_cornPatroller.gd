extends InimigoBase

var patrulhando : bool = false
@onready var velocidade_old = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if lado_esquerdo:
		virar()

func _physics_process(delta):
	if estaMorrer:
		return
	if !is_on_floor():
		velocity.y += gravity * delta
	elif is_on_floor():
		if !patrulhando:
			if chao_detect.is_colliding():
				velocity.x = -velocidade
			else:
				patrulhando = true
				await virar()
		else:
			velocity.x = 0
	if Input.is_action_just_pressed("interagir"):
		patrulhando = !patrulhando
	print(velocity)
	estou_vivo()
	auto_animar("walk", "idle", "jump", "fall")
	move_and_slide()

func fall():
	if !is_on_floor() and position.y > 200000:
		animacoes.play("fall")

func _on_target_body_entered(body):
	#Caso o inimigo tenha mais de duas vidas o player vai ser afetado só pelo knockback
	if vida_total >= 0  and body.is_in_group("Vegetal"):
		var ataque = Ataque.new()
		ataque.dano_ataque = 0
		ataque.forca_knockback = forca_knockback * 0.5
		ataque.posicao_ataque = global_position
		body.dano(ataque)

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
		patrulhando = true
		virar()

func virar():
	print("virar")
	if patrulhando:
		await get_tree().create_timer(3).timeout
		print("patrulhou ja")
	scale.x = abs(scale.x) * -1
	patrulhando = false
	velocidade = -velocidade
