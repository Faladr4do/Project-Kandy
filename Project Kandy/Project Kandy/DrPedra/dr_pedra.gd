extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var esta_respirar = true
var esta_falar = false

@onready var local_falar = $Marker2D.global_position
@onready var animPedra = $AnimationPlayer
@onready var spritePedra = $Sprite2D

const falas: Array[String] = [
	"Bons dias jovem",
	"O meu nome é Lelo, e de onde eu venho sou uma pedra",
	"LEO É O MEU GATO RAWR"
]

func _physics_process(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta
	if is_on_floor():
		if esta_respirar:
			animPedra.play("idle_respirar")
		elif esta_falar:
			animPedra.play("falar")
			
	move_and_slide()

func _on_area_dialogo_body_entered(body):
	if body.is_in_group("Vegetal"):
		if Input.is_action_just_pressed("interagir"):
			esta_falar = true
			Dialog.comecar_dialogo(local_falar, falas)
			esta_falar = false
		else:
			esta_falar = false


func _on_area_voltar_dr_body_entered(body):
	if body.is_in_group("Vegetal"):
		scale.x = abs(scale.x) * -1
		
func pestanejar():
	if esta_respirar and !esta_falar:
		await get_tree().create_timer(3).timeout
		animPedra.play("idle_pestanejar")
		esta_respirar = true
		
