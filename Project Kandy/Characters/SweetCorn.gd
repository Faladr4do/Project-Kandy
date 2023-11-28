extends CharacterBody2D


const SPEED = 20.0
const JUMP_VELOCITY = -140.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animCorn = $AnimationPlayer
@onready var spriteCorn = $Sprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		spriteCorn.flip_h = (direction == 1)
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	atualizar_Anims(direction)
	fall()
	
func atualizar_Anims(direction):
	if is_on_floor():
		if direction == 0:
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
		animCorn.stop()
		animCorn.play("dead")
