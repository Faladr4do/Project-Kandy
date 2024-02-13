extends InimigoBase

var patrulhando : bool = false
var pode_andar : bool = false
var esta_virar : bool = false
@onready var velocidade_old = 0

func _ready():
	if lado_esquerdo:
		virar()

func _physics_process(delta):
	if estaMorrer:
		return
	if !is_on_floor():
		velocity.y = gravity * delta
	if !patrulhando and is_on_floor():
		velocity.x = velocidade
	else:
		velocity.x = 0
		patrulhando = true
		virar()
	#print(pode_andar, patrulhando)
	estou_vivo()
	#verificador_andamento(delta)
	auto_animar("walk", "idle", "jump", "fall")
	move_and_slide()
	
func verificador_andamento(delta):
	if patrulhando:
		return
	if is_on_floor() and esta_virar:
		if chao_detect.is_colliding():
			pode_andar = true
		else:
			print("chao nao deteta")
			pode_andar = false
	else:
		velocity.y += gravity * delta

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
	esta_virar = true
	if patrulhando:
		print_debug("parado")
		await get_tree().create_timer(3).timeout
		#print("patrulhou ja")
	scale.x = abs(scale.x) * -1
	patrulhando = false
	velocidade = -velocidade
	esta_virar = false
