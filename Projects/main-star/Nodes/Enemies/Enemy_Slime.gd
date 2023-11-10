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

@export var slimelvl = 0
@onready var smallSlime = preload("res://Nodes/Enemies/enemy_slime_small.tscn")

# sobreescribir el metodo
func _on_health_component_on_dead():
	#print("dead of enemigo, spawning exp")
	var gem = exp_gem.instantiate()  # C	rea una instancia del objeto de experiencia.
	gem.global_position = self.global_position  # Coloca el objeto de experiencia en la posición del enemigo.
	get_parent().call_deferred("add_child", gem)
	if self.slimelvl > 0:
		var smallSlime_instance = smallSlime.instantiate()
		smallSlime_instance.position = (self.global_position)
		get_parent().call_deferred("add_child", smallSlime_instance)
		# get_parent().call_deferred("add_child", smallSlime_instance)
