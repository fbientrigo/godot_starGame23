extends Label

func _ready():
	pass

func _process(_delta):
	var fps = Engine.get_frames_per_second()
#	print(fps)
	text = " FPS: " + str(fps)
