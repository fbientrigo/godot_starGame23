extends Button


func _on_mouse_entered():
	self.scale = 1.02 * Vector2.ONE
	self.modulate = Color(1,1,1)


func _on_mouse_exited():
	self.scale = Vector2.ONE
	self.modulate = Color(0.762, 0.596, 1)
