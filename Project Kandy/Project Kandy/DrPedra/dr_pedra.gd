extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var conta_idle = 0

var intro_feita = false
var esta_falar = false

@onready var area_interagir: AreaInteragir = $AreaInteragir

@onready var local_falar = $Marker2D.global_position
@onready var animPedra = $AnimationPlayer
@onready var spritePedra = $Sprite2D

const intro: Array[String] = [
	"Bons dias jovem",
	"O meu nome é Lelo, e de onde eu venho sou uma pedra",
	"LEO É O MEU GATO RAWR"
]

var falas: Array[String] = [
	"Não, desculpe não tenho moedinhas",
	"Já te disse que tenho um gato?",
	"Tou bué confortável"
]


func _ready():
	area_interagir.interagir = Callable(self, "_on_interact")

func _physics_process(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta
	
	esta_falar = Dialog.dialogo_ativo 
	gerir_idle()
	move_and_slide()

func _on_animation_player_animation_finished(anim_name):
	if !esta_falar:
		if anim_name == "idle_respirar":
			conta_idle += 1
		elif anim_name == "idle_pestanejar":
			conta_idle = 0

#Dialogo começa assim que o player entra na area
func _on_area_dialogo_body_entered(body):
	if body.is_in_group("Vegetal") and !intro_feita:
		Dialog.comecar_dialogo(local_falar, intro)
		intro_feita = true
	elif intro_feita:
		Dialog.comecar_dialogo(local_falar, falas)
		#do this#

func _on_area_voltar_dr_body_entered(body):
	if body.is_in_group("Vegetal"):
		scale.x = abs(scale.x) * -1

func gerir_idle():
	if esta_falar:
		animPedra.play("falar")
	else:
		if conta_idle != 5:
			animPedra.play("idle_respirar")
			await animPedra.animation_finished
		elif conta_idle == 5:
			animPedra.play("idle_pestanejar")
			await animPedra.animation_finished
