extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#https://www.youtube.com/watch?v=ef065J7reGw
	pass


func _on_luminosidade_value_changed(value):
	Ambiente.environment.adjustment_brightness = value
