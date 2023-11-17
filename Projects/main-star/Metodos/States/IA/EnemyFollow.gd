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
var player:RigidBody2D #aqui guardaremos al player
var direction : Vector2

#func _ready():
#	print("EnemyFollow:")
#	print(enemy)

func Enter():
	var player_group_nodes = get_tree().get_nodes_in_group("Player")
	for player_node in player_group_nodes:
		player = player_node
		break
	if enemy == null or player == null:
		return

	movement.call_deferred("setup",enemy)
	#movement.setup(enemy)

	
	direction = player.global_position - enemy.global_position
	# 1115 probe quitarlo apra el bug del movimeino
	# enemy.movement.move(direction)



#		if enemy.animation != null:

	
func Physics_Update(_delta: float):
	if enemy != null:
		if player != null:
			direction = player.global_position - enemy.global_position
		if direction.length() < rango_vision_player:
			movement.move(direction)
			#animation.play("move_anim")
	
