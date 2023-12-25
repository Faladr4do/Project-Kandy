extends Area2D

@onready var sprite_kaboom = $Sprite2D
@onready var anim_kaboom = $AnimationPlayer
@onready var som_explosivo = $explosion

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Explosivo")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	"""som_explosivo.play()
	anim_kaboom.play("explode")
	#fix temporario
	await get_tree().create_timer(0.5).timeout
	#await som_explosivo.finished
	queue_free()"""

func _on_explosion_finished():
	pass


func _on_animation_player_animation_finished(anim_name):
	pass
