extends StarState
class_name TipoK

# Propiedades específicas para TipoK
@export var masa := 0.7 #masas solares
@export var temperatura := 4500 #kelvin
@export var abundancia := 8 #porcentaje
@export var tiempo_vida := 50000 # millón de años

@onready var collision_shape = preload("res://Nodes/Star/collision_K.tres")

func Enter():
	healthcomponent.collision.shape = collision_shape
	animacion.play("K")
