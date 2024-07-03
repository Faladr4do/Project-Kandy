extends ObjetoFalante

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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
