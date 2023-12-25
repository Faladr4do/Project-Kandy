extends Area2D

@onready var sprite_kaboom = $Sprite2D
@onready var anim_kaboom = $AnimationPlayer
@onready var som_explosivo = $explosion

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Explosivo")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("cheguei")
	anim_kaboom.play("explode")

func _on_explosion_finished():
	pass


func _on_animation_player_animation_finished(anim_name):
	queue_free()
