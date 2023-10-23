extends StarState
class_name TipoM

# Propiedades específicas para TipoM
@export var masa := 0.2 #masas solares
@export var temperatura := 3200 #kelvin
@export var abundancia := 80 #porcentaje
@export var tiempo_vida := 20000 # millón de años

@onready var collision_shape = preload("res://Nodes/Star/collision_M.tres")

func Enter():
	healthcomponent.collision.shape = collision_shape
	animacion.play("M")
