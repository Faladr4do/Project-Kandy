extends Node2D

var patrulhando : bool = true

func _process(delta):
	if patrulhando:
		await get_tree().create_timer(3).timeout
		await patrulhar()
	printer()

func printer():
	if patrulhando:
		print("patrulhando")
	else:
		print("andar")

func patrulhar():
		patrulhando = false
		await get_tree().create_timer(7).timeout
		patrulhando = true

#extends Node2D
#
#var patrulhando : bool = true
#
#func _process(delta):
	#if patrulhando:
		#await get_tree().create_timer(3).timeout
		#patrulhando = false
	#elif !patrulhando:
		#await get_tree().create_timer(7).timeout
		#patrulhando = true
	#printer()
#
#func printer():
	#if patrulhando:
		#print("patrulhando")
	#else:
		#print("andar")
