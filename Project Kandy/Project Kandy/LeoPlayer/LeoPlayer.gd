extends CharacterBody2D

const SPEED = 55.0
const JUMP_VELOCITY = -140.0
var relogio = Timer.new()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animLeo = $AnimationPlayer
@onready var spriteLeo = $Sprite2D
@onready var mira : Marker2D = $caster
@export var fire : PackedScene = preload("res://fireball.tscn")

var doubleJump = false
var lentoTempo = false

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
		
	#Voltar ao inicio do jogo
	if Input.is_action_just_pressed("reiniciar"):
		get_tree().reload_current_scene()
		
	
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
		estigar()
	
	var direction = Input.get_axis("left", "right")
	
	if direction != 0:
		#spriteLeo.flip_h = (direction == -1)
		scale.x = scale.y * direction

	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	atualizar_Anims(direction)
	
func atualizar_Anims(direction):
	if is_on_floor():
		if direction == 0:
			animLeo.play("idle")
		else:
			animLeo.play("walk")
	else:
		if velocity.y < 0:
			animLeo.play("jump")
		elif velocity.y > 200:
			animLeo.play("fall")
			
func devolta():
	Engine.set_time_scale(1)
	lentoTempo = false

func estigar():
	var cena_estigada = fire.instantiate()
	owner.add_child(cena_estigada)
	cena_estigada.global_position = mira.global_position
