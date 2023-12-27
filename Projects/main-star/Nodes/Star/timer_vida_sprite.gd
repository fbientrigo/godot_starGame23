extends Sprite2D

@onready var timer_vida : Timer = $"../Timer_Vida"


func ready():
	pass

func _process(_delta):
	# frame += 1
	print("wait time; ",timer_vida.wait_time) # wait time es fijo
	print("time left; ",timer_vida.time_left) # time left es variable
	print("calculo de timer frame", calculate_frame())
	frame = calculate_frame()

func calculate_frame():
	var percent_frames : float = timer_vida.time_left/timer_vida.wait_time
	return lerp(hframes-1,0, percent_frames)
