extends Control


func _on_play_pressed():
	# desde el menu al pricipal
	get_tree().change_scene_to_file("res://Scenes/space_scene_1.tscn")


func _on_options_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit() #salir del juego.exe
