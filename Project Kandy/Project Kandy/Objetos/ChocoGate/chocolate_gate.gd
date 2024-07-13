extends AnimatableBody2D

@export var lvl_pass : PackedScene
@export var entrada : bool = true

@onready var area_door : AreaInteragir = $AreaInteragir
@onready var anims : AnimationPlayer = $AnimationPlayer

var trancada : bool = true

func _ready():
	area_door.interagir = Callable(self, "inter_act")
	if !entrada:
		anims.play("close")

func inter_act():
	if anims.current_animation == "idle_closed":
		anims.play("open")

func _process(delta):
	if Dialogic.VAR.falou_shroom and Dialogic.VAR.falou_father:
		trancada = false
	if entrada:
		if !trancada:
			area_door.monitoring = true
		else:
			area_door.monitoring = false
	else :
		area_door.monitoring = false

func _on_animation_finished(anim_name):
	if anim_name == "open":
		anims.play("idle_opened")
		await get_tree().create_timer(0.5).timeout
		var spawn_passer = lvl_pass.instantiate()
		add_child(spawn_passer)
		spawn_passer.global_position = global_position
	if anim_name == "close":
		anims.play("idle_closed")
