#extends CanvasLayer

#func set_tower_preview(tower_type, mouse_position):
#	var drag_tower = load("res://Characters/Star/" + tower_type + ".tscn").instance()
#
#	drag_tower.set_name("DragTower")
#	drag_tower.modulate = Color("ad54ff3c")
#
#	var control = Control.new()
#	control.rect_position = mouse_position
#	control.set_name("TowerPreview")
#