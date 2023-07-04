extends State
class_name EnemyFolow

# La probabilidad de atacar al player funcionará de manera que si encuentra
# al jugador dentro de cierta distancia
# tira los dados, y a pesar de que tenga como target una estrella
# decidira re atacar al jugador
# si un enemigo se encuentra con un nivel de daño puede cambiarse esta Probab.


@export var enemy: CharacterBody2D
@export var move_speed:= 40
@export var rango_vision_player := 100
@export var probabilidad_atacar_player := 0.9
var player:CharacterBody2D
var direction : Vector2

func Enter():
	# por default su velocidad inicial va hacia el jugador
	player = get_tree().get_first_node_in_group("Player")
	direction = player.global_position - enemy.global_position
	enemy.movement.move(direction, move_speed)
	
func Physics_Update(delta: float):
	direction = player.global_position - enemy.global_position
	if direction.length() < rango_vision_player:
		enemy.movement.move(direction, move_speed)
		
	
