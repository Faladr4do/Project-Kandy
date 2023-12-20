extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var rng = RandomNumberGenerator.new()
var random

@onready var area_interagir: AreaInteragir = $AreaInteragir

@onready var local_falar = $Marker2D.global_position
@onready var animPedra = $AnimationPlayer
@onready var spritePedra = $Sprite2D

const falas: Array[String] = [
	"Bons dias jovem",
	"O meu nome é Lelo, e de onde eu venho sou uma pedra",
	"LEO É O MEU GATO RAWR"
]

func _ready():
	area_interagir.interagir = Callable(self, "_on_interact")

func _physics_process(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

func _on_interact():
	Dialog.comecar_dialogo(local_falar, falas)

func _on_area_dialogo_body_entered(body):
	if body.is_in_group("Vegetal"):
		pass


func _on_area_voltar_dr_body_entered(body):
	if body.is_in_group("Vegetal"):
		scale.x = abs(scale.x) * -1

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "idle_respirar":
		random = rng.randi_range(0,10)
		print(random)
		if random >= 5:
			animPedra.play("idle_pestanejar")
		else:
			animPedra.play("idle_respirar")
