extends CharacterBody2D

const vel_salto = -580

@onready var velocy = 480.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var estaVivo = true
var estaMorrer = false
var patrulhando = false
var diff_speed_aerial = 0.6
var explodindo = false

@onready var animBomb = $AnimationPlayer
@onready var spriteBomb = $Sprite2D
@onready var chao = $RayCast2D
@onready var alvo = $target
@onready var explosao = $"Explosão"

func _ready():
	add_to_group("Inimigo")
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

	move_and_slide()
	atualizar_Anims(velocy)
	fall()
	
func atualizar_Anims(velocy):
	if estaMorrer:
		return
	if is_on_floor():
		if velocy == 0:
			animBomb.play("jumper")
		else:
			animBomb.play("jumper")
	else:
		if velocity.y < 0:
			animBomb.play("jumper")
		#elif position.y > 200:
			#animBomb.play("dead")

func fall():
	if !is_on_floor() and position.y > 200000:
		animBomb.play("jumper")


func _on_hitbox_body_entered(body):
	if body.is_in_group("Vegetal"):
		morte()

func _on_target_body_entered(body):
	if body.is_in_group("Bala"):
		morte()
	elif body.is_in_group("Vegetal"):
		explodir()
		morte()

func _on_teste_frente_body_entered(body):
	if body.is_in_group("Vegetal") or body.is_in_group("Bala"):
		pass
	else:
		virar()

func _on_explosão_body_entered(body):
	if body.is_in_group("Vegetal") and explodindo:
		pass


func explodir():
	explodindo = true
	await animBomb.animation_finished
	queue_free()
	
func virar():
	scale.x = abs(scale.x) * -1
	velocy= velocy * -1

func morte():
	if estaMorrer:
		return
	animBomb.play("dead")
	$hitbox/CollisionShape2D.call_deferred("set_disabled", true)
	$CollisionShape2D.call_deferred("set_disabled", true)
	estaMorrer = true
	await get_tree().create_timer(0.75).timeout
	queue_free()