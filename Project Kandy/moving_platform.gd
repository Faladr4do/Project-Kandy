extends Path2D

@export var loop = true
@export var velocidade = 10

@onready var caminho = $PathFollow2D
@onready var animacion = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if loop:
		animacion.play("move")
		set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	caminho.progress += velocidade
