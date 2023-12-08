extends CharacterBody2D


@onready var velocy = -20.0
@onready var velocyOld = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var estaVivo = true
var estaMorrer = false
var patrulhando = false
var velocy_old = 0


@onready var animCorn = $AnimationPlayer
@onready var spriteCorn = $Sprite2D
@onready var chao = $RayCast2D
@onready var alvo = $target

func _ready():
	add_to_group("Inimigo")
	alvo.add_to_group("Alvo")
	

func _physics_process(delta):
	if estaMorrer:
		return
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
	atualizar_Anims(velocy)
	fall()
	
func atualizar_Anims(velocy):
	if estaMorrer:
		return
	if is_on_floor():
		if velocy == 0:
			animCorn.play("idle")
		else:
			animCorn.play("walk")
	else:
		if velocity.y < 0:
			animCorn.play("jump")
		#elif position.y > 200:
			#animCorn.play("dead")

func fall():
	if not is_on_floor() and position.y > 200:
		animCorn.play("dead")


func _on_hitbox_body_entered(body):
	if body.is_in_group("Vegetal"):
		morte()

func _on_target_body_entered(body):
	if body.is_in_group("Bala"):
		morte()
	elif body.is_in_group("Vegetal"):
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
	$hitbox/CollisionShape2D.call_deferred("set_disabled", true)
	$CollisionShape2D.call_deferred("set_disabled", true)
	estaMorrer = true
	await get_tree().create_timer(0.75).timeout
	queue_free()

func virar():
	velocy_old= velocy
	velocy= velocy*0
	print(velocy)
	await get_tree().create_timer(3).timeout
	print(velocy)
	velocy= velocy*1
	scale.x = abs(scale.x) * -1
	velocy= velocy * -1
