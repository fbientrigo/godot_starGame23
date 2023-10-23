extends AnimatedSprite2D


func _on_animation_finished():
	print("animacion terminada")
	# al terminar la animacion, desaparece
	queue_free()


# un catch extra
func _on_animation_looped():
	print("animacion terminada loop")
	# al terminar la animacion, desaparece
	queue_free()
