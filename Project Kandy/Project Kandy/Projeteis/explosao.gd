extends Area2D

var dano = Global.dano_explosivo

@onready var sprite_kaboom = $Sprite2D
@onready var anim_kaboom = $AnimationPlayer
@onready var som_explosivo = $explosion

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Explosivo")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	anim_kaboom.play("explode")

func _on_animation_player_animation_finished(anim_name):
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("Vegetal"):
		body.dano(dano)
