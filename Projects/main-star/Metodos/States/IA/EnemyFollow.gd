extends State
class_name EnemyFolow



# La probabilidad de atacar al player funcionará de manera que si encuentra
# al jugador dentro de cierta distancia
# tira los dados, y a pesar de que tenga como target una estrella
# decidira re atacar al jugador
# si un enemigo se encuentra con un nivel de daño puede cambiarse esta Probab.


@export var enemy:CharacterBody2D #el character bodypropio
# @export var move_speed:= 40
@export var rango_vision_player := 100
@export var probabilidad_atacar_player := 0.9
@onready var movement : Movement = $"../../Movement"
var player_and_stars: Node2D #aqui guardaremos al player
var direction : Vector2

#func _ready():
#	print("EnemyFollow:")
#	print(enemy)

func Enter():
	movement.call_deferred("setup",enemy)
	var player_group_nodes = get_tree().get_nodes_in_group("Aliados")
	if player_group_nodes != []:
		player_and_stars = player_group_nodes.pick_random()
		direction = player_and_stars.global_position - enemy.global_position
		
#	for player_node in player_group_nodes:
#		player_and_stars = player_node
#		break


	#movement.setup(enemy)

	
	
	# 1115 probe quitarlo apra el bug del movimeino
	# enemy.movement.move(direction)



#		if enemy.animation != null:

	
func Physics_Update(_delta: float):
	if enemy != null:
		if player_and_stars != null:
			direction = player_and_stars.global_position - enemy.global_position
			if direction.length() < rango_vision_player:
				movement.move(direction)
				#movement.move_to(player_and_stars)
				print("working mvement")
			#animation.play("move_anim")
	
