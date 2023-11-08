extends Enemy


@export var wait_time = 0.5  # tiempo de espera entre saltos en segundos
var timer = 0.0  # temporizador para llevar la cuenta del tiempo

#func _process(delta):
#	timer += delta  # incrementa el temporizador
#	if timer >= wait_time:
#		timer = 0.0  # reinicia el temporizador
#		move(player_area, speed)  # realiza un movimiento
#	else:
#		stop_movement()
#
