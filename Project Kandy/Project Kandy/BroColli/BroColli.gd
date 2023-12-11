extends CharacterBody2D

const SPEED = 55.0
const JUMP_VELOCITY = -150.0
var relogio = Timer.new()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animColli = $AnimationPlayer
@onready var spriteColli = $Sprite2D
@onready var mira : Marker2D = $Sprite2D/Marker2D
@onready var estigar_cooldown = $"estigar cooldown"

@export var fire : PackedScene = preload("res://Project Kandy/Projeteis/fireball.tscn")

var doubleJump = false
var lentoTempo = false
var estaAtacar = false
var cooldown = false


func _ready():
	add_to_group("Vegetal")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		doubleJump = true
	elif Input.is_action_just_pressed("jump") and doubleJump == true:
			velocity.y = JUMP_VELOCITY*1.3
			doubleJump = false
		
	if Input.is_action_just_pressed("reiniciar"):
		morrer()
	
	if Input.is_action_just_pressed("slown") and lentoTempo == false:
		lentoTempo = true
		relogio.connect("timeout", Callable(self, "devolta"))
		relogio.wait_time = 2
		relogio.one_shot = true
		add_child(relogio)
		Engine.set_time_scale(0.5)
		relogio.start()
	elif Input.is_action_just_pressed("slown") and lentoTempo == true:
		relogio.stop()
		relogio.emit_signal("timeout")
		
	if Input.is_action_just_pressed("estigar"):
		if !cooldown and !estaAtacar:
			estaAtacar = true
			animColli.play("shoot")
			await animColli.animation_finished
			estigar()
			estaAtacar = false
			cooldown = true
			await estigar_cooldown.timeout
			cooldown = false
		else:
			pass
	
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		scale.x = scale.y * direction
	
	print(scale.y)
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	atualizar_Anims(direction)
	
func atualizar_Anims(direction):
	if estaAtacar:
		return
	if is_on_floor():
		if direction == 0:
			animColli.play("idle")
		else:
			animColli.play("walk")
	else:
		if velocity.y < 0:
			animColli.play("jump")
		elif velocity.y > 200:
			animColli.play("fall")
			
func devolta():
	Engine.set_time_scale(1)
	lentoTempo = false

func estigar():
	var cena_estigada = fire.instantiate()
	if scale.y < 0:
		cena_estigada.velocidade = -90
	elif scale.y > 0:
		cena_estigada.velocidade = 90
	owner.add_child(cena_estigada)
	cena_estigada.global_position = mira.global_position


func _on_hitbox_body_entered(body):
	if body.is_in_group("Inimigo"):
		if Global.vidas_totais > 0:
			Global.vidas_totais -= 1
		elif Global.vidas_totais <= 0:
			morrer()
			Global.vidas_totais = 3
		
func morrer():
	get_tree().reload_current_scene()
