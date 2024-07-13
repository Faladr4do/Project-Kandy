extends ObjetoFalante

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if Dialogic.VAR.falou_shroom:
		dialogo = "sou_father"
	else:
		dialogo = "sem_dialogo"
	
	if !is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
