extends Enemy
class_name SlimeMultiplier


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
@onready var smallSlime = preload("res://Nodes/Enemies/enemy_slime_small_fix.tscn")


var flag_spawn_slime : bool = false

func spawn_slime():
	var smallSlime_instance = smallSlime.instantiate()
	#var smallSlime_instance2 = smallSlime.instantiate()
	var theta = 2 * PI *  randf()
	var spawn_radius = 20
	var spawn_position = Vector2(spawn_radius * cos(theta), spawn_radius * sin(theta))
	smallSlime_instance.global_position = self.global_position + spawn_position
	#smallSlime_instance2.global_position = self.global_position + spawn_position
	
	# smallSlime_instance2.velocity = Vector2(100,100)
	#get_tree().get_nodes_in_group("Level")[0].call_deferred("add_child", smallSlime_instance)
	#get_tree().get_nodes_in_group("Level")[0].add_child(smallSlime_instance)
	var level = get_tree().get_nodes_in_group("Level")[0]
	
	level.call_deferred("add_child", smallSlime_instance)


func _process(delta):
	if flag_spawn_slime:
		spawn_slime()
		flag_spawn_slime = false
		

# sobreescribir el metodo
func _on_health_component_on_dead():
	#print("dead of enemigo, spawning exp")
	if self.slimelvl == 0:
		var gem = exp_gem.instantiate()  # C	rea una instancia del objeto de experiencia.
		gem.global_position = self.global_position  # Coloca el objeto de experiencia en la posición del enemigo.
		get_parent().call_deferred("add_child", gem)
	elif self.slimelvl > 0:
		spawn_slime()
		var gem = exp_gem.instantiate()  # C	rea una instancia del objeto de experiencia.
		gem.global_position = self.global_position  # Coloca el objeto de experiencia en la posición del enemigo.
		get_parent().call_deferred("add_child", gem)


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
