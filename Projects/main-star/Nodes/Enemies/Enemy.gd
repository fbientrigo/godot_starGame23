# Script para definir a los enemigos en el juego.
# Los enemigos son personajes que pueden perseguir al jugador y dañarlo.
# Estas son sus características específicas.

# Idea del Módulo Enemigo
# El módulo de enemigo representa a los personajes en el juego que actúan como
# inteligencia artificial. Estos personajes tienen la capacidad de detectar al jugador,
# perseguirlo y causarle daño. El módulo define las características y comportamientos
# específicos de los enemigos en el juego.

# Objetivo de Algunos Enemigos
# - Tipo Zerg: Estos enemigos están diseñados para absorber vida de las estrellas y
#   multiplicarse. Tienen la capacidad de rastrear a las estrellas y consumirlas para
#   su reproducción.
# - Tipo Terran: Estos enemigos consumen asteroides de manera similar al jugador y
#   tienen la capacidad de crear su propio imperio en el juego.

# Capacidades del Modelo Actual
# El modelo actual del módulo de enemigo posee las siguientes capacidades:
# - Detección de jugador basada en la distancia de visión.
# - Persecución del jugador manteniendo una distancia mínima.
# - Reproducción de animaciones utilizando el nodo de animación.
# - Configuración del movimiento del enemigo mediante el nodo de movimiento.
# - Detección del jugador utilizando un sensor de área.
# - Capacidad para procesar la lógica de ataque (a implementar según sea necesario).
# - Gestión de la salud y la lógica de muerte del enemigo.
extends CharacterBody2D
class_name Enemy # crea una clase


# Distancia de visión del enemigo para detectar al jugador.
@export var distancia_vision: float
# Distania mínima a mantener entre el enemigo y el jugador.
@export var distancia_minima: float
# Indica si la visión del enemigo es eterna o no (siempre persigue al jugador).
@export var vision_eterna: bool
# Referencia al nodo de animación para controlar las animaciones del enemigo.
@export var animation : AnimatedSprite2D 
# Refeencia al nodo de movimiento que permite al enemigo moverse.
#@onready var movement = $Movement as Movement
@export var movement : Movement
# Referencia al sensor del enemigo que detecta al jugador.
@onready var sensor: Area2D = $Sensor
@onready var animation_player:AnimationPlayer = $AnimationPlayer


# Referencia al jugador detectado por el sensor.
var player
var player_area

# exp
var exp_gem : PackedScene

func _ready(): # Método llamado cuando el nodo está listo.
	movement.setup(self) # Configura el movimiento del enemigo.
	#animation.play("base_anim") # Reproduce la animación base.
	exp_gem = preload("res://Nodes/Objects/Object.tscn")
	animation.play("damage_anim")
	animation.pause()
	

func _physics_process(_delta):
	pass

# Nota: Código de seguimiento del jugador se ha comentado temporalmente.
# Implementa esta lógica según tus necesidades específicas.

# --- Sensor ---
# Función llamada cuando el sensor detecta un cuerpo entrando en su área.
func _on_sensor_body_entered(_body):
	pass

# Función llamada cuando el sensor detecta un cuerpo saliendo de su área.
func _on_sensor_body_exited(_body):
	pass

# Función llamada cuando el sensor detecta un área entrando en su área.
func _on_sensor_area_entered(area):
	# Almacena el área detectada, que se asume como el jugador.
	player_area = area

# Función llamada cuando el sensor detecta un área saliendo de su área.
func _on_sensor_area_exited(_area):
	# Restablece el área del jugador cuando sale del sensor.
	player_area = null

# Función llamada cuando el componente de salud del enemigo alcanza una salud de 0.
# Puede implementar acciones adicionales aquí, como cambiar la animación y eliminar al enemigo.

func _on_health_component_on_dead():
	#print("dead of enemigo, spawning exp")
	var gem = exp_gem.instantiate()  # C	rea una instancia del objeto de experiencia.
	gem.global_position = self.global_position  # Coloca el objeto de experiencia en la posición del enemigo.
	get_parent().call_deferred("add_child", gem)



var times_damaged = 0
func _on_health_component_hurt(damage):
	animation_player.play("AnimationsLibrary_Enemies/hurt_animation") # este es un damage anim
	if times_damaged == 0:
		times_damaged += 1
		animation.frame = 0
	elif times_damaged > 0:
		times_damaged += 1
		animation.frame += 1
	elif times_damaged > 8:
		animation.frame = 8
		