extends InimigoBase


@onready var velocy = -160.0
@onready var velocyOld = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var estaVivo = true
var patrulhando = false
var velocy_old = 0

func _ready():
	add_to_group("Vivo")
	add_to_group("Inimigo")
	add_to_group("Inimigo_Tocador")
	alvo.add_to_group("Alvo")
	

func _physics_process(delta):
	if estaMorrer:
		return
	if !is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		if chao.is_colliding():
			velocity.x = velocy
		else:
			patrulhar()
#	if is_on_floor() or is_on_wall():
#		if chao.is_colliding() and !is_on_wall():
#			velocity.x = velocy
#		elif !chao.is_colliding() or is_on_wall():
#			virar()
	
	estou_vivo()
	move_and_slide()
	auto_animar("walk", "idle", "jump", "fall")
	fall()

func fall():
	if !is_on_floor() and position.y > 200000:
		animacoes.play("fall")


func _on_hitbox_body_entered(body):
	if body.is_in_group("Vegetal"):
		morte(animacoes)

func _on_target_body_entered(body):
	if estaMorrer:
		return
	if body.is_in_group("Bala"):
		morte(animacoes)
	elif body.has_method("dano"):
		var ataque = Ataque.new()
		ataque.dano_ataque = dano_forca
		ataque.forca_knockback = forca_knockback
		ataque.posicao_ataque = global_position
		body.dano(ataque, estaMorrer)
	virar()

func _on_teste_parede_body_entered(body):
	if body.is_in_group("Vegetal") or body.is_in_group("Bala"):
		pass
	else:
		patrulhar()

func virar():
	scale.x = abs(scale.x) * -1
	velocy= -velocy

func patrulhar():
	velocy_old= velocy
	velocy= 0
	await get_tree().create_timer(3).timeout
	velocy= velocy_old
	scale.x = abs(scale.x) * -1
	velocy= velocy * -1


func _on_target_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("Bala"):
		morte(animacoes)
	else:
		pass
