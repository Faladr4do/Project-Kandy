extends CharacterBody2D

@export var dano = 1000.0

const SPEED = 55.0
const JUMP_VELOCITY = -140.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animNick = $AnimationPlayer
@onready var spriteNick = $Sprite2D

var doubleJump = false

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
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	if direction != 0:
		spriteCorn.flip_h = (direction == -1)
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	atualizar_Anims(direction)
	
func atualizar_Anims(direction):
	if is_on_floor():
		if direction == 0:
			animNick.play("idle")
		else:
			animNick.play("walk")
	else:
		if velocity.y < 0:
			animNick.play("jump")
		elif velocity.y > 200:
			animNick.play("fall")
			

