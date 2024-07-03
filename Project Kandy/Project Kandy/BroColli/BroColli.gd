extends VegetalPlayer

@onready var jump_audio = $PlayerJump
@onready var pea_throw = $PeaThrow

const SPEED = 440.0
const  JUMP_VELOCITY = 900.0
var relogio = Timer.new()

var vida_max = Global.vidas_max
@export var boss1_won : bool = false
var jumping : bool = true

func _physics_process(delta):
	if Dialogic.VAR.dialogo != 0:
		return
	#print_debug(Dialogic.VAR.ervilhas)
	# Add the gravity.
	if !is_on_floor():
		velocity.y += (gravity * delta) * speed
	if is_on_floor() and !pode_saltar:
		pode_saltar = true
	elif pode_saltar and tempo_coyote.is_stopped():
		tempo_coyote.start()
# Handle Jump.
	if Input.is_action_just_pressed("jump") and pode_saltar:
		print("salto1")
		jump_audio.play()
		velocity.y = -JUMP_VELOCITY
		jumping = true
		if boss1_won:
			doubleJump = true
		pode_saltar = false
	elif Input.is_action_just_pressed("jump") and doubleJump:
		print("salto2")
		jump_audio.play()
		velocity.y = -(JUMP_VELOCITY * 1)
		doubleJump = false
		jumping = false
	
	if Input.is_action_just_pressed("reiniciar") and !receber_dano:
		vida_total = Global.vidas_max
		print_debug(get_tree())
		get_tree().reload_current_scene()
	
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
		
	if Input.is_action_pressed("estigar") and Dialogic.VAR.ervilhas:
		if !cooldown and !estaAtacar:
			estaAtacar = true
			pea_throw.play()
			animacoes.play("shoot")
			await animacoes.animation_finished
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
	
	#print_debug(sprite.material._get_shader_rid)
	
	hit_flash_play()
	move_and_slide()
	atualizar_Anims(direction)

func atualizar_Anims(direction):
	if estaAtacar:
		return
	if is_on_floor():
		jumping = false
		if direction == 0:
			animacoes.play("idle")
		else:
			animacoes.play("walk")
	else:
		if velocity.y < 0 and jumping:
			animacoes.play("jump")
		elif velocity.y > 0:
			animacoes.play("fall")

func devolta():
	speed = 1
	Engine.set_time_scale(1)
	lentoTempo = false

func estigar():
	shoot(fire, 120, caster)

func player_comprador_method():
	pass

func _on_pes_body_entered(body):
	#print(body.get_groups())
	if body.is_in_group("Inimigo"):
		var ataque = Ataque.new()
		ataque.dano_ataque = dano_forca
		ataque.forca_knockback = forca_knockback
		ataque.posicao_ataque = global_position
		body.dano(ataque)

func _on_tempo_coyote_timeout():
	pode_saltar = false
