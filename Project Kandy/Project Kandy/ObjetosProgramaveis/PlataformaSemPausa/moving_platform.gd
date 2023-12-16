extends Path2D

@export var loop = true
@export var velocidade = 60
@export var escala_vel = 1

@onready var caminho = $PathFollow2D
@onready var animacion = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if !loop:
		animacion.play("move")
		animacion.speed_scale = escala_vel
		set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	caminho.progress += velocidade
