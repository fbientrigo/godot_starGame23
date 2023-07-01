extends CharacterBody2D
class_name Enemy # crea una clase

# para game designer
@export var distancia_vision: float # controla a que distancai sigue al jugador
@export var distancia_minima: float # si el enemigo desea acercarse o no
@export var vision_eterna: bool

# as Movement permite el autocompletado para que entienda el nodo
@onready var movement: Movement = $"Movement" as Movement
@onready var sensor: Area2D = $"Sensor"


# almacena el vector de movimeinto
var player

func _ready(): # conecta todo lo importante
	movement.setup(self)
	

func _physics_process(delta):
	if player != null:
		# |r - r'|
		var direction = player.global_position - global_position
		var distancia = global_position.distance_to(player.global_position)
		
		if distancia < distancia_vision: # vio al jugador
			if distancia > distancia_minima:
				movement.move(direction)
			
		elif vision_eterna:
			if distancia > distancia_minima:
				movement.move(direction)			
					
		




# --- Sensor ---
func _on_sensor_body_entered(body):
	pass
func _on_sensor_body_exited(body):
	pass

# se prueba usar body's
func _on_sensor_area_entered(area):
	# agregar comprobación de jugador usando layers
	player = area
	print("area:", player)


func _on_sensor_area_exited(area):
	# comprobacion
	print("area exited:", player)
	player = null
	

