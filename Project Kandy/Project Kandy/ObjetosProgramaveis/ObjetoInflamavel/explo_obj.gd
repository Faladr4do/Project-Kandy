extends ObjetoExplosivo

func _ready():
	add_to_group("ObjetoExplosivo")

func _process(delta):
	if vida_total < 0:
		explodir()
		queue_free()
