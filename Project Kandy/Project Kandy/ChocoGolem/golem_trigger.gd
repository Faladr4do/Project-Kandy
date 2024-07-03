extends Area2D

var golem

func _ready():
	golem = get_parent()

func _on_body_entered(body):
	if body.is_in_group("Vegetal"):
		golem.wake_up()
		queue_free()
