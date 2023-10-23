extends StarState
class_name TipoB

# Propiedades específicas para TipoB
@export var masa := 10 #masas solares
@export var temperatura := 20000 #kelvin
@export var abundancia := 0.1 #porcentaje
@export var tiempo_vida := 100 # millón de años

@onready var collision_shape = preload("res://Nodes/Star/collision_B.tres")

func Enter():
	healthcomponent.collision.shape = collision_shape
	animacion.play("B")
