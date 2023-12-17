extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var esta_pestanejar = false

@onready var local_falar = $Marker2D.global_position

const falas: Array[String] = [
	"Bons dias jovem",
	"O meu nome é Lelo, e de onde eu venho sou uma pedra",
	"LEO É O MEU GATO RAWR"
]

func _physics_process(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func _on_area_dialogo_body_entered(body):
	if body.is_in_group("Vegetal"):
		Dialog.comecar_dialogo(local_falar, falas)


func _on_area_voltar_dr_body_entered(body):
	if body.is_in_group("Vegetal"):
		scale.x = abs(scale.x) * -1
