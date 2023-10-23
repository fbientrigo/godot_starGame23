extends StarState
class_name TipoO

# Propiedades específicas para TipoO
@export var masa := 50 #masas solares
@export var temperatura := 40000 #kelvin
@export var abundancia := 0.00001 #porcentaje
@export var tiempo_vida := 10 # millón de años

@onready var collision_shape = preload("res://Nodes/Star/collision_O.tres")

func Enter():
	healthcomponent.collision.shape = collision_shape
	animacion.play("O")

