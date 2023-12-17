extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const lines = [
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
		Global.moedas_coletadas *= 2
		Dialog.comecar_dialogo(global_position, lines)
