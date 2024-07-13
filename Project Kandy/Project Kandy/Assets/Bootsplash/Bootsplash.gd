extends Control


func _on_audio_finished():
	$AudioStreamPlayer2.play()


func _on_audio_2_finished():
	get_tree().change_scene_to_file("res://Project Kandy/Menus/menu_index.tscn")
