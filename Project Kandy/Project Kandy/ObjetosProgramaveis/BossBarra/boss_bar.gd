extends CanvasLayer

@export var boss : Boss_Character

@onready var barra : TextureProgressBar = $Control/TextureProgressBar
@onready var anims : AnimationPlayer = $Control/TextureProgressBar/AnimationPlayer

var boss_health : float
var faded : bool = false

func _ready():
	boss_health = boss.vida_total
	barra.max_value = boss_health

func _physics_process(delta):
	if boss:
		if boss.awaken:
			if anims.current_animation != "fade_in" and !faded:
				visible = true
				anims.play("fade_in")
		if !boss_health <= 0:
			boss_health = boss.vida_total
			barra.value = boss_health
		if boss.estaMorrer and anims.current_animation != "fade_out":
			anims.play("fade_out")

func boss_end():
	pass

func _on_animation_finished(anim_name):
	if anim_name == "fade_in":
		faded = true
		anims.play("fill_bar")
	if anim_name == "fade_out":
		queue_free()
