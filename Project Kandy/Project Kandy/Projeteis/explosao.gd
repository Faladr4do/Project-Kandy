extends Area2D

@export var dano_explosivo : int = 1
@export var forca_knockback = 3000
@export var cor = 1

var explodiu = false

@onready var sprite_kaboom = $Sprite2D
@onready var anim_kaboom = $AnimationPlayer
@onready var som_explosivo = $explosion

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Explosivo")
	if cor == 1:
		$".".modulate = Color(1, 1, 1)
	elif cor == 2:
		$".".modulate = Color(1, 0, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	anim_kaboom.play("explode")

func _on_animation_player_animation_finished(anim_name):
	queue_free()

func _on_body_entered(body):
	if body.has_method("dano"):
		var ataque = Ataque.new()
		ataque.dano_ataque = dano_explosivo
		ataque.forca_knockback = forca_knockback
		ataque.posicao_ataque = global_position
		body.dano(ataque)

func mudar_cor():
	if cor == 1:
		sprite_kaboom.modulate = Color(1, 1, 1)
	elif cor == 2:
		sprite_kaboom.modulate = Color(1, 0, 1)

func stuff():
	pass
