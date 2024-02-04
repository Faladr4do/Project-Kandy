extends CanvasLayer

signal acabou_transicao

@onready var cor_transicao : ColorRect = $ColorRect
@onready var mostrar_animacao : AnimationPlayer = $AnimationPlayer

func _ready():
	cor_transicao.visible = false
	mostrar_animacao.animation_finished.connect(_on_animation_finished)


func _on_animation_finished(anim_name):
	if anim_name == "desvanecer":
		acabou_transicao.emit()
		mostrar_animacao.play("aparecer")
	elif anim_name == "aparecer":
		cor_transicao.visible = false

func transicao():
	cor_transicao.visible = true
	mostrar_animacao.play("desvanecer")
