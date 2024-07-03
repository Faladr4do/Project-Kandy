extends TileMap

@export var golem : Golem

func _physics_process(delta):
	if golem and golem.vida_total <= 0:
		queue_free()
