extends Area2D

@onready var sprite_kaboom = $Sprite2D
@onready var anim_kaboom = $AnimationPlayer
@onready var som_explosivo = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Explosivo")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	som_explosivo.play()
	anim_kaboom.play("explode")
	await anim_kaboom.animation_finished
	queue_free()


