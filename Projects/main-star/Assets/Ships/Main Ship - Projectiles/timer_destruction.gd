extends Timer


@export var destruction_timer : float

func _on_visible_on_screen_notifier_2d_screen_exited():
	# cuando la bala sale de la pantalla; el timer comienza
	start(destruction_timer)
	

