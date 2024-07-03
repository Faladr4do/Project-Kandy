extends ObjetoFalante

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var local_falar = $Marker2D.global_position

const falas: Array[String] = [
	"Hello!",
	"Im a lil zesty",
	"I'm trippin af, BIATCH!"
]

func _physics_process(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.has_method("player_comprador_method"):
		Dialogic.start(dialogo)
		get_viewport().set_input_as_handled()
		#Global.moedas_coletadas *= 2
		#Dialog.comecar_dialogo(local_falar, falas)
