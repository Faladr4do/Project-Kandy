extends InimigoExplosivo

const vel_salto = -580

@onready var velocy = 480.0

var estaVivo = true
var patrulhando = false
var diff_speed_aerial = 0.6
var explodindo = false

func _ready():
	add_to_group("Inimigo")
	if !lado_esquerdo:
		virar()

func _physics_process(delta):
	if estaMorrer:
		return
	if !is_on_floor():
		velocity.y += (gravity * delta) * diff_speed_aerial
		velocity.x = velocy * diff_speed_aerial
	if is_on_floor():
		if chao_detect.is_colliding():
			velocity.x = velocy
			velocity.y = vel_salto
		elif !chao_detect.is_colliding():
			animacoes.play("rolar")
	estou_vivo()
	move_and_slide()
	atualizar_Anims(velocy)
	fall()
	
func atualizar_Anims(velocy):
	if estaMorrer:
		return
	if is_on_floor():
		if velocy == 0:
			animacoes.play("idle")
		else:
			animacoes.play("idle")
	else:
		if velocity.y < 0:
			animacoes.play("idle")
		#elif position.y > 200:
			#animacoes.play("dead")

func fall():
	if !is_on_floor() and position.y > 200000:
		animacoes.play("idle")


func _on_target_body_entered(body):
	pass
	#if body.is_in_group("Vegetal"):
		#morte()

func _on_hitbox_body_entered(body):
	if estaMorrer:
		return
	if body.is_in_group("Vegetal"):
		explodir()
		morte()

func _on_teste_frente_body_entered(body):
	if body.is_in_group("Vegetal") or body.is_in_group("Bala"):
		pass
	else:
		virar()

func virar():
	scale.x = abs(scale.x) * -1
	velocy= velocy * -1
