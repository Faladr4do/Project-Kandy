extends InimigoBase

@export var cuspo : PackedScene

@onready var spot : Area2D = $Spot

var cor : int

func _ready():
	if !lado_esquerdo:
		virar()
	if vida_total > 0:
		colocar_capacete()
	randomizar_cor()
	print_debug(cor)

func _physics_process(delta):
	if estaMorrer:
		return
	spot.monitoring = !spot.monitoring
	if !is_on_floor():
		velocity.y += gravity * delta
	elif is_on_floor():
		if chao_detect.is_colliding() and !esta_atacar:
			velocity.x = -velocidade
		elif !chao_detect.is_colliding():
			virar()
	destruir_capacete()
	estou_vivo()
	auto_animar("andar", "cuspir", "jump", "fall")
	move_and_slide()

func virar():
	scale.x = abs(scale.x) * -1
	velocidade= -velocidade


func _on_teste_parede_body_entered(body):
	if body.is_in_group("Vegetal") or body.is_in_group("Bala"):
		pass
	else:
		virar()

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

func _on_target_body_entered(body):
	if vida_total >= 0  and body.is_in_group("Vegetal"):
		body.velocity.y = -forca_knockback * 0.4


func _on_spot_body_entered(body):
	if body.is_in_group("Vegetal") and !esta_atacar:
		esta_atacar = true
		velocity.x = 0
		animacoes.play("cuspir")

func _on_animation_finished(anim_name):
	if anim_name == "cuspir":
		shoot(cuspo,-60, caster)
		await get_tree().create_timer(2).timeout
		esta_atacar = false

func randomizar_cor():
	cor = randi_range(1,3)
	if cor == 1:
		modulate= Color(1,1,1)
	if cor == 2:
		modulate= Color(1,8,1)
	if cor == 3:
		modulate= Color(1,1,8)
