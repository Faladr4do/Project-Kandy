extends EntidadeViva

const vel_salto = -580

@onready var velocy = 480.0

@export var kaboom : PackedScene = preload("res://Project Kandy/Projeteis/explosao.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var estaVivo = true
var patrulhando = false
var diff_speed_aerial = 0.6
var explodindo = false

@onready var chao = $RayCast2D
@onready var alvo = $target

func _ready():
	add_to_group("Vivo")
	add_to_group("Inimigo")
	add_to_group("Inimigo_Longo")
	alvo.add_to_group("Alvo")

func _physics_process(delta):
	if estaMorrer:
		return
	if !is_on_floor():
		velocity.y += (gravity * delta) * diff_speed_aerial
		velocity.x = velocy * diff_speed_aerial
	if is_on_floor():
		if chao.is_colliding():
			velocity.x = velocy
			velocity.y = vel_salto
		elif !chao.is_colliding():
			virar()
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


func _on_hitbox_body_entered(body):
	if body.is_in_group("Vegetal"):
		morte()

func _on_target_body_entered(body):
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

func explodir():
	var cena_explosiva = kaboom.instantiate()
	cena_explosiva.cor = 1
	owner.call_deferred("add_child", cena_explosiva)
	cena_explosiva.global_position = sprite.global_position
	
func virar():
	scale.x = abs(scale.x) * -1
	velocy= velocy * -1

func _on_target_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("Bala"):
		explodir()
		morte()
