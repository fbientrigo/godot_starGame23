extends AnimatedSprite2D

# sirve para des instanciar ua animacion de explosion

func _on_animation_finished():
	queue_free()

# un catch extra
func _on_animation_looped():
	queue_free()
