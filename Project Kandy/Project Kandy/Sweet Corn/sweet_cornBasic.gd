extends EntidadeViva


@onready var velocy = -160.0
@onready var velocyOld = 0

@export var lado_esquerdo : bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var estaMorrer = false
var patrulhando = false

@onready var animCorn = $AnimationPlayer
@onready var spriteCorn = $Sprite2D
@onready var chao = $RayCast2D
@onready var alvo = $target

func _ready():
	add_to_group("Vivo")
	add_to_group("Inimigo")
	add_to_group("Inimigo_Tocador")
	alvo.add_to_group("Alvo")
	scale.x = abs(scale.x) * -1
	if lado_esquerdo:
		pass
	else:
		virar()

func _physics_process(delta):
	if estaMorrer:
		return
	print(vida_total)
	if !is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		if chao.is_colliding() and !is_on_wall():
			velocity.x = velocy
		elif !chao.is_colliding():
			virar()
#	if is_on_floor() or is_on_wall():
#		if chao.is_colliding() and !is_on_wall():
#			velocity.x = velocy
#		elif !chao.is_colliding() or is_on_wall():
#			virar()
	
	move_and_slide()
	auto_animar("walk", "idle", "jump", "fall")
	fall()
	
#func atualizar_Anims(velocy):
	#if estaMorrer:
		#return
	#if is_on_floor():
		#if velocy == 0:
			#animCorn.play("idle")
		#else:
			#animCorn.play("walk")
	#else:
		#if velocity.y < 0:
			#animCorn.play("jump")
		#elif position.y > 200:
			#animCorn.play("dead")

func fall():
	if !is_on_floor() and position.y > 200000:
		animCorn.play("fall")


func _on_hitbox_body_entered(body):
	if body.has_method("dano"):
		print("body_hitbox")
		var ataque = Ataque.new()
		ataque.dano_ataque = dano_forca
		ataque.forca_knockback = forca_knockback
		ataque.posicao_ataque = global_position
		body.dano(ataque, estaMorrer)

func _on_target_body_entered(body):
	if estaMorrer:
		return
	if body.has_method("dano"):
		print("body_target")
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
		virar()


func morte():
	if estaMorrer:
		return
	animCorn.play("dead")
	$hitbox/CollisionPolygon2D.call_deferred("set_disabled", true)
	$CollisionPolygon2D.call_deferred("set_disabled", true)
	estaMorrer = true
	await get_tree().create_timer(0.75).timeout
	queue_free()

func virar():
	scale.x = abs(scale.x) * -1
	velocy= -velocy

func _on_target_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("Bala"):
		morte()
