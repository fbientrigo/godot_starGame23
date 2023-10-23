extends StarState
class_name TipoA

# Propiedades específicas para TipoA
@export var masa := 2 #masas solares
@export var temperatura := 8500 #kelvin
@export var abundancia := 0.7 #porcentaje
@export var tiempo_vida := 1000 # millón de años

@onready var collision_shape = preload("res://Nodes/Star/collision_A.tres")

func Enter():
	healthcomponent.collision.shape = collision_shape
	animacion.play("A")
