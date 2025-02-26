extends Golem

@onready var golem_spcial : AudioStreamPlayer2D = $SpcialStomp
@onready var golem_melee : AudioStreamPlayer2D = $Melee
@onready var golem_stomp : AudioStreamPlayer2D = $Stmp
@onready var caster_coluna : Marker2D = $ColunaMarker
@onready var caster_wave : Marker2D = $WaveMarker
@onready var move_timer : Timer = $MovementTimer
@onready var area_attack : Area2D = $AreaAttack

@export var coluna : PackedScene
@export var choco_wave : PackedScene
@export var choco_bigwave : PackedScene

func _physics_process(delta):
	# Add the gravity.
	add_to_group("Boss")
	if !is_on_floor():
		velocity.y += gravity * delta
	if !awaken or animacoes.current_animation == "death":
		return
	elif estaMorrer:
		move_timer.stop()
		animacoes.play("dead")
		return
	#if is_on_floor() and can_attack and !esta_atacar:
		#if vida_total <= vida_fase2:
			#special_attack()
		#else:
			#summon_column()
	if direction != 0:
		scale.x = scale.y * -direction
	if direction and !esta_atacar and !is_crouch:
		if animacoes.current_animation != "idle":
			velocity.x = (direction * velocidade)
	else:
		velocity.x = move_toward(velocity.x, 0, velocidade)
	if Input.is_action_just_pressed("z_special"):
		can_attack = true
	if !can_attack and !esta_atacar:
		if velocity.x != 0 and !is_crouch:
			animacoes.play("walk")
			print_debug("started")
			move_timer.start()
		elif velocity.x == 0 and !is_crouch:
			animacoes.play("idle")
			if move_timer.is_stopped():
				print_debug("started_stoped")
				move_timer.start()
		elif velocity.x == 0 and is_crouch:
			animacoes.play("get_up")
	if !esta_atacar:
		player_distance()
	else :
		move_timer.start()
	hit_flash_play()
	move_and_slide()

func player_distance():
	print_debug(distance_player)
	if distance_player > 150.0:
		if !is_crouch:
			direction = 1
	elif distance_player < -150.0:
		if !is_crouch:
			direction = -1
	if distance_player == -150.0 or 150.0:
		can_attack = true

func _on_animation_finished(anim_name):
	if anim_name == "awaken":
		awaken = true
		animacoes.play("idle")
	if anim_name == "death":
		estaMorrer = true
	if anim_name == "special":
		can_attack = false
		is_crouch = true
		esta_atacar = false
		animacoes.play("get_up")
	if anim_name == "get_up":
		is_crouch = false
		can_attack = false
	if anim_name == "melee_attack":
		can_attack = false
		esta_atacar = false
	if anim_name == "summon_coluna":
		can_attack = false
		animacoes.play("pre_stomp")
	if anim_name == "pre_stomp":
		esta_atacar = false
		stomp_attack()
	if anim_name == "stomp":
		stompin = false
		stomp_number += 1
		if stomp_number >= stomp_count:
			esta_atacar = false
			stomp_number = 0
			animacoes.play("get_up")
		else:
			stomp_attack()

func _on_animation_started(anim_name):
	if anim_name == "get_up":
		is_crouch = true
	if anim_name == "death":
		print_debug("dead")
		await get_tree().create_timer(0.7).timeout
		collisionShape.disabled = true
		sprite.self_modulate = Color(0.8, 0.8, 0.8, 1)
	if anim_name == "special":
		await get_tree().create_timer(0.2).timeout
		shoot(coluna, 0, caster_coluna)
		await get_tree().create_timer(1.9).timeout
		golem_spcial.play()
		shoot(choco_bigwave, 300, caster_wave)
	if anim_name == "stomp":
		await get_tree().create_timer(0.9).timeout
		golem_stomp.play()
		shoot(choco_wave, 300, caster_wave)
	if anim_name == "summon_coluna":
		await get_tree().create_timer(0.2).timeout
		shoot(coluna, 0, caster_coluna)
	if anim_name == "melee_attack":
		await get_tree().create_timer(0.7).timeout
		golem_melee.play()
		melee = true
		area_attack.monitoring = false
		area_attack.monitoring = true
		print_debug(melee)

func _on_movement_timer_timeout():
	if distance_player < 600 or -600:
		if vida_total <= vida_fase2:
			special_attack()
		else:
			summon_column()
	else:
		move_timer.start()

func area_ataque(body):
	if body.is_in_group("Vegetal"):
		if animacoes.current_animation == "walk":
			ataque_melee()
		if melee:
			var ataque = Ataque.new()
			ataque.dano_ataque = dano_forca
			ataque.forca_knockback = forca_knockback * 2
			ataque.posicao_ataque = global_position
			body.dano(ataque)
			melee = false
