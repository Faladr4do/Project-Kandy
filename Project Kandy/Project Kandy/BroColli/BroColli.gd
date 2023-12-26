extends CharacterBody2D

const SPEED = 440.0
const  JUMP_VELOCITY = -900.0
var relogio = Timer.new()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animColli = $AnimationPlayer
@onready var spriteColli = $Sprite2D
@onready var mira : Marker2D = $Sprite2D/Marker2D
@onready var estigar_cooldown = $"estigar cooldown"
@onready var hit_flash = $HitFlashAnimPlay
@onready var hitbox = $hitbox

@export var fire : PackedScene = preload("res://Project Kandy/Projeteis/fireball.tscn")

var doubleJump = false
var lentoTempo = false
var estaAtacar = false
var cooldown = false
var speed = 1
var tempo_coyote = 0.0
var temporizar_coyote = 0.1


func _ready():
	add_to_group("Vegetal")

func _physics_process(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity.y += (gravity * delta) * speed


	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		doubleJump = true
	elif Input.is_action_just_pressed("jump") and doubleJump:
			velocity.y = JUMP_VELOCITY * 1
			doubleJump = false
		
	if Input.is_action_just_pressed("reiniciar"):
		morrer()
	
	if Input.is_action_just_pressed("slown") and !lentoTempo:
		lentoTempo = true
		speed = 2
		relogio.connect("timeout", Callable(self, "devolta"))
		relogio.wait_time = 2
		relogio.one_shot = true
		add_child(relogio)
		Engine.set_time_scale(0.5)
		relogio.start()
	elif Input.is_action_just_pressed("slown") and !lentoTempo:
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
	if direction:
		velocity.x = (direction * SPEED) * speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor():
		tempo_coyote

	verificar_vida()
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
		if velocity.y < 0 and doubleJump:
			animColli.play("jump")
		elif velocity.y > 0:
			animColli.play("fall")

func devolta():
	speed = 1
	Engine.set_time_scale(1)
	lentoTempo = false

func estigar():
	var cena_estigada = fire.instantiate()
	if scale.y < 0:
		cena_estigada.velocidade = -100
	elif scale.y > 0:
		cena_estigada.velocidade = 100
	owner.add_child(cena_estigada)
	cena_estigada.global_position = mira.global_position

func verificar_vida():
	if Global.vidas_totais >= 0:
		pass
	elif Global.vidas_totais < 0:
		morrer()

func _on_hitbox_body_entered(body):
	if body.is_in_group("Inimigo_Tocador"):
		print("ouch toque")
		Global.vidas_totais -= Global.dano_toque
		hit_flash.play("hit_flash")

func _on_hitbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if !hit_flash.is_playing():
		if area.is_in_group("Explosivo"):
			print("ouch explosão")
			Global.vidas_totais -= Global.dano_explosivo
			hit_flash.play("hit_flash")
		if area.is_in_group("Obstaculo"):
			print("ouch obstaculo")
			Global.vidas_totais -= Global.dano_obstaculo
			hit_flash.play("hit_flash")

func player_comprador_method():
	pass

func morrer():
	get_tree().reload_current_scene()
	Global.vidas_totais = Global.vidas_max

func dano():
	hitbox.monitoring = false
	hit_flash.play("hit_flash")
	await get_tree().create_timer(75).timeout
	hitbox.monitoring = true


