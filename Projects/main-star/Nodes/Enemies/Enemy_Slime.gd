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


func _ready():
	animation.play("damaged_anim")
	print(animation)

# sobreescribir el metodo
func _on_health_component_on_dead():
	#print("dead of enemigo, spawning exp")
	if self.slimelvl == 0:
		var gem = exp_gem.instantiate()  # C	rea una instancia del objeto de experiencia.
		gem.global_position = self.global_position  # Coloca el objeto de experiencia en la posición del enemigo.
		get_parent().call_deferred("add_child", gem)
	elif self.slimelvl > 0:
		var smallSlime_instance = smallSlime.instantiate()
		smallSlime_instance.position = (self.global_position)
		get_parent().call_deferred("add_child", smallSlime_instance)
		# get_parent().call_deferred("add_child", smallSlime_instance)


func _on_health_component_hurt(damage):
	print(animation.frame)
	animation_player.play("AnimationsLibrary_Enemies/hurt_animation") # este es un damage anim
	if times_damaged == 0:
		times_damaged += 1
		animation.frame = 0
	elif times_damaged > 0:
		times_damaged += 1
		animation.frame += 1
	elif times_damaged > 8:
		animation.frame = 8
